//
//  ContentView.swift
//  Traffiker
//
//  Created by Dmytro Kholodov on 11/6/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI
import Combine

class TrafficModel: ObservableObject {
    @Published var expiration: Date = Date() {
        willSet {
            calc(newExpiration: newValue, newRemaining: remaining)
        }
        didSet {
            _storage.save(expiration: expiration, remaining: remaining, remainingPerDay: remainingPerDay, history: [])
        }
    }
    @Published var remaining: Double = 0 {
        willSet {
            calc(newExpiration: expiration, newRemaining: newValue)
        }
        didSet {
            _storage.save(expiration: expiration, remaining: remaining, remainingPerDay: remainingPerDay, history: [])
        }
    }
    @Published var remainingPerDay: Double = 0 {
        didSet {
            _storage.save(expiration: expiration, remaining: remaining, remainingPerDay: remainingPerDay, history: [])
        }
    }
    @Published var changedByVol: Double = 0

    @Published var historyPerDay: [Double]

    var remainingDays: Int {
        calculateRemainingDays(expirationDate: expiration)
    }

    var dayChanged: AnyCancellable? = nil

    init(_ storage: Storage) {
        self._storage = storage
        let (expr, rem) = (storage.expiration, storage.remaining)
        self.expiration = expr
        self.remaining = rem
        self.historyPerDay = storage.historyPerDay

        self.dayChanged = NotificationCenter
            .default
            .publisher(for: NSNotification.Name.NSCalendarDayChanged)
            .receive(on: RunLoop.main)
            .sink { _ in

                self.historyPerDay[self.historyPerDay.endIndex - 1] += self.changedByVol

                self.calc(
                    newExpiration: self.expiration,
                    newRemaining: self.remaining)

                self._storage.save(
                    expiration: self.expiration,
                    remaining: self.remaining,
                    remainingPerDay: self.remainingPerDay,
                    history: [])
            }
    }

    private var _storage: Storage
}

extension TrafficModel {
    func calculateRemainingDays(expirationDate: Date) -> Int {
        let calendar = Calendar.current
        let end = calendar.startOfDay(for: expirationDate)
        let now = calendar.startOfDay(for: Date())

        let components = calendar.dateComponents([.day], from: now, to: end)
        return components.day ?? 0
    }

    func calc(newExpiration: Date, newRemaining: Double) {

        let days = Double(calculateRemainingDays(expirationDate: newExpiration))
        if days > 0 {
            let newPerDay = newRemaining / days
            let oldPerDay = self.remainingPerDay
            self.remainingPerDay = newPerDay
            self.changedByVol = newPerDay - oldPerDay
        }
    }
}


struct Storage {

    let ud = UserDefaults.standard

    static let keyExpiration = "expiration"
    static let keyRemaining = "remaining"
    static let keyRemainingPerDay = "remainingPerDay"
    static let keyHistoryPerDay = "historyPerDay"

    let defaultRemainingVolume = 10_000_000_000.0

    var expiration: Date {
        if ud.value(forKey: Storage.keyExpiration) != nil {
            let interval = ud.double(forKey: Storage.keyExpiration)
            return Date(timeIntervalSince1970: interval)
        } else {
            return Date()
        }
    }

    var remaining: Double {
        if ud.value(forKey: Storage.keyExpiration) != nil {
            return ud.double(forKey: Storage.keyRemaining)
        } else {
            return defaultRemainingVolume
        }
    }

    var remainingPerDay: Double {
        if ud.value(forKey: Storage.keyRemainingPerDay) != nil {
            return ud.double(forKey: Storage.keyRemainingPerDay)
        } else {
            return 0
        }
    }

    var historyPerDay: [Double] {
//        if ud.value(forKey: Storage.keyHistoryPerDay) != nil {
//            return ud.array(forKey: Storage.keyHistoryPerDay) as! [Double]
//        } else {
            return [100, 200, 0, 20, 400, 130, 145, 65, 144]
  //      }
    }

    func save(expiration: Date, remaining: Double, remainingPerDay: Double, history: [Double]) {
        ud.set(expiration.timeIntervalSince1970, forKey: Storage.keyExpiration)
        ud.set(remaining, forKey: Storage.keyRemaining)
        ud.set(remainingPerDay, forKey: Storage.keyRemainingPerDay)
        ud.set(history, forKey: Storage.keyHistoryPerDay)
    }
}


struct OfflineView: View {
    var body: some View {
        HStack {
            Image(systemName: "sun.haze")
            Text("Offline, huh?")
        }.foregroundColor(.yellow)
    }
}

struct OnlineView: View {
    var remainingPerDay: Double
    var changedByVol: Double = 0


    var byteFormatter: ByteCountFormatter {
        let formatter = ByteCountFormatter()
        return formatter
    }

    var formatted: String {
        self.byteFormatter.string(fromByteCount: Int64(self.remainingPerDay))
    }
    var formattedChanged: String {
        self.byteFormatter.string(fromByteCount: Int64(abs(self.changedByVol)))
    }
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "arrow.up.circle")
                .foregroundColor(.green)
            Text(formatted)
            if changedByVol != 0 {
                Group {
                    Spacer()
                    Text(changedByVol < 0 ? "-" : "+")
                    Text(formattedChanged)
                }
                .foregroundColor(changedByVol < 0 ? .red : .green)
                .animation(.default)
            }
        }
    }

}

struct InputView: View {
    @Binding var expiration: Date
    @Binding var remaining: Double
    @Binding var showHelp: Bool

    var body: some View {
        Section {
            DatePicker(selection: $expiration, in: Date()..., displayedComponents: .date) {
                Text("Active up to").foregroundColor(.primary)
            }
            .foregroundColor(.yellow)
            if showHelp {
                Text("Select a date when the Internet package will expire.").fontWeight(.light).font(.footnote).foregroundColor(.secondary)
            }

            VStack(alignment: .leading, spacing: 20) {

                HStack {
                    Text("Volume")

                    Spacer()

                    Text("\(byteFormatter.string(fromByteCount: Int64(remaining)))")
                        .foregroundColor(.yellow)
                }

                HStack {
                    Button(action: {
                        self.showHelp.toggle()
                    }, label: {
                        Image(systemName: showHelp ? "chevron.up.circle" : "chevron.down.circle")
                    }).foregroundColor(.gray).font(.footnote)

                    Spacer()

                    Stepper("Change the remaining volume", value: $remaining, in: 0...Double.infinity, step: 100 * 1000 * 1000)
                        .labelsHidden().scaleEffect(1.5)
                        .offset(x: -20, y: -10)
                }

                if showHelp {
                    HStack {
                        Picker("Change the remaining volume", selection: $remaining) {
                            ForEach(Array(stride(from: 1_000_000_000.0, to: 10_000_000_000.0, by: 2_000_000_000)), id: \.self) { vol in
                                Text("\(self.byteFormatter.string(fromByteCount: Int64(vol)))")
                                    .foregroundColor(.yellow)
                            }
                        }.pickerStyle(SegmentedPickerStyle()).labelsHidden()
                    }

                    Text("Update the actual volume as the time passes and keep track how it is splitted among the remaining days.").fontWeight(.light).font(.footnote).foregroundColor(.secondary)
                }
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    private var byteFormatter: ByteCountFormatter {
        let formatter = ByteCountFormatter()
        return formatter
    }
}

struct OutputView: View {
    @Binding var showHelp: Bool
    var remainingDays: Int
    var remainingPerDay: Double
    var changedByVol: Double

    let showMaxDays = 5

    var body: some View {

        VStack(alignment: .leading) {
            //Text("Split equally among")
            HStack {
                Text("\(remainingDays)")
                Image(systemName: "sun.haze")
                Text("day\(((remainingDays > 1) ? "s" : ""))")
            }
            .animation(.default)
            .foregroundColor(.yellow).font(.largeTitle)

            List(0..<min(showMaxDays, remainingDays), id: \.self) { _ in
                if self.remainingPerDay > 0 {
                    OnlineView(remainingPerDay: self.remainingPerDay, changedByVol: self.changedByVol)
                } else {
                    OfflineView()
                }
            }

            if remainingDays > showMaxDays {
                HStack {
                    Image(systemName: "plus.circle.fill").rotationEffect(Angle(degrees: -5))
                        .offset(x: 10, y: 0).foregroundColor(.green).zIndex(1)
                    Text("\(remainingDays - showMaxDays)")
                        .padding(5)
                        .overlay(Circle().stroke()).rotationEffect(Angle(degrees: -5))
                    Text("day\(((remainingDays - showMaxDays > 1) ? "s" : ""))").foregroundColor(.secondary)
                }
            }
            if showHelp {
                Text("If you split the remaining volume withing the remaining day you will get this per-day break-down.")
                    .fontWeight(.light)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }

    }
}

struct Bar: View {
    var value: CGFloat
    var max: CGFloat
    var color: Color {
        switch value {
        case 0..<(max/2):
            return Color.green
        case (max/2)...:
            return Color.red
        default:
            return Color.yellow
        }
    }
    var body: some View {
        Capsule()
        .foregroundColor(color)
        .frame(
            width: 10,
            height: (value / max) * 200.0)
    }
}

struct HistoryChart: View {
    var values: [CGFloat]
    var remainingDays: Int
    var max: CGFloat
    var showHelp: Bool

    let limitOfDays = 14

    init(values: [Double], remainingDays: Int, showHelp: Bool) {
        self.values = values.suffix(limitOfDays).map { CGFloat($0) } //+ Array(repeating: -1, count: min(remainingDays, limitOfDays))
        self.max = self.values.max() ?? 1
        self.remainingDays = remainingDays
        self.showHelp = showHelp
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("History")
            ScrollView(.horizontal) {
                HStack(alignment: .bottom) {
                    ForEach(Array(values.indices), id: \.self) { i in
                        Bar(value: self.values[i], max: self.max)
                    }
                }.padding(.vertical)
            }

            if showHelp {
                Text("Your traffic for the active period.")
                    .fontWeight(.light)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct About: View {
    var displayName: String {
        guard let info = Bundle.main.infoDictionary else { return "" }
        guard let name = info["CFBundleName"] as? String else { return "" }
        return name
    }

    var version: String {
        guard let info = Bundle.main.infoDictionary else { return "" }
        guard let ver = info["CFBundleShortVersionString"] as? String else { return "" }
        return "v\(ver)"
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(displayName)
                .font(.caption)
                .foregroundColor(.primary)
                .fontWeight(.light)
                +
                Text(" ")
                +
                Text(version)
                    .font(.footnote)
                    .fontWeight(.light)
//            Text("A traffik calculator from the Trekopedia team").fontWeight(.light).font(.footnote)
        }
        .foregroundColor(.gray)
    }
}

struct TraffikerView: View {
    @ObservedObject var stored = TrafficModel(Storage())

    let dayChanged = NotificationCenter.default
        .publisher(for: NSNotification.Name.NSCalendarDayChanged)

    @State var refreshed = true
    @State var showHelp = true

    var title = "₸₹₳₣₣Ị₭€₹"
    
    var body: some View {
        NavigationView {
            Form {
                InputView(
                    expiration: $stored.expiration,
                    remaining: $stored.remaining,
                    showHelp: $showHelp)

                if stored.remainingDays > 0 {
                    Section {
                        OutputView(
                            showHelp: $showHelp,
                            remainingDays: stored.remainingDays,
                            remainingPerDay: stored.remainingPerDay,
                            changedByVol: stored.changedByVol)
                    }
                } else {
                    OfflineView()
                }

                Section {
                    HistoryChart(values: stored.historyPerDay, remainingDays: stored.remainingDays, showHelp: showHelp)//.id(111)
                }

                Section(footer: About()) {
                    EmptyView()
                }
            }
            .navigationBarTitle(title)


            .onReceive(dayChanged) { _ in
                self.refreshed.toggle()
            }
        }
    }
}


struct ContentView: View {
    var body: some View {
        TraffikerView()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
