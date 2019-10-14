//
//  ContentView.swift
//  Px1_Compass
//
//  Created by Dmytro Kholodov on 10/10/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct Marker: Hashable {
    let degrees: Double
    let label: String

    init(degrees: Double, label: String = "") {
        self.degrees = degrees
        self.label = label
    }

    func degreeText() -> String {
        return String(format: "%.0f", self.degrees)
    }

    static func markers() -> [Marker] {
        return [
            Marker(degrees: 0, label: "S"),
            Marker(degrees: 30),
            Marker(degrees: 60),
            Marker(degrees: 90, label: "W"),
            Marker(degrees: 120),
            Marker(degrees: 150),
            Marker(degrees: 180, label: "N"),
            Marker(degrees: 210),
            Marker(degrees: 240),
            Marker(degrees: 270, label: "E"),
            Marker(degrees: 300),
            Marker(degrees: 330)
        ]
    }
}

struct CompassMarkerView: View {
    let marker: Marker
    let compassDegress: Double

    var body: some View {
        VStack {
            Text(marker.degreeText())
                    .fontWeight(.light)
                    .rotationEffect(self.textAngle())

            Capsule()
                    .frame(width: self.capsuleWidth(),
                            height: self.capsuleHeight())
                    .foregroundColor(self.capsuleColor())
                    .padding(.bottom, 120)

            Text(marker.label)
                    .fontWeight(.bold)
                    .rotationEffect(self.textAngle())
                    .padding(.bottom, 80)
        }.rotationEffect(Angle(degrees: marker.degrees))
    }

    private func capsuleWidth() -> CGFloat {
        return self.marker.degrees == 0 ? 7 : 3
    }

    private func capsuleHeight() -> CGFloat {
        return self.marker.degrees == 0 ? 45 : 30
    }

    private func capsuleColor() -> Color {
        return self.marker.degrees == 0 ? .red : .gray
    }

    private func textAngle() -> Angle {
        return Angle(degrees: -self.compassDegress - self.marker.degrees)
    }
}

struct ContentView: View {
    @ObservedObject var compassHeading = CompassHeading()

    var body: some View {
        VStack {
            Capsule()
                .frame(width: 5, height: 50)

            ZStack {
                ForEach(Marker.markers(), id: \.self) { marker in
                    CompassMarkerView(marker: marker,
                    compassDegress: 0)
                }
            }.frame(width: 300,
                   height: 300)
            .rotationEffect(Angle(degrees: self.compassHeading.degrees))
            .statusBar(hidden: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
