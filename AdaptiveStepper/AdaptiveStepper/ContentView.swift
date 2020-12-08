//
//  ContentView.swift
//  AdaptiveStepper
//
//  Created by Dmytro Kholodov on 11/13/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI


struct AdaptiveStepper: View {
    @State var refresh: Bool = false

    @Binding var selection: Int

    init(selection: Binding<Int>) {
        self._selection = selection
        self.range = Binding(
            get: {
                [selection.wrappedValue - 1, selection.wrappedValue, selection.wrappedValue + 1] },
            set: { _ in })
    }

    var range: Binding<[Int]>

    var body: some View {
        let binding = Binding(
            get: {
                self.selection
            },
            set: {
                self.selection = $0
                // FIX: how to refresh Picker's content reliably???
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.refresh.toggle()
                }
            }
        )

        return
            Picker("Value", selection: binding) {
                ForEach(self.range.wrappedValue, id: \.self) { i in
                    Text("\(i)")
                }
            }.pickerStyle(SegmentedPickerStyle())

    }
}

struct ContentView: View {
    @State var amount = 1
    var body: some View {
        VStack {
            Text("\(amount)")
                .font(.system(size: 200))
                .foregroundColor(.green)
            AdaptiveStepper(selection: $amount)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
