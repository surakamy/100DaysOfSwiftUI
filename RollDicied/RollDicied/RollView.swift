//
//  RollView.swift
//  RollDicied
//
//  Created by Dmytro Kholodov on 12/29/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct RollView: View {
    var dices: [Int]
    var total: Binding<Int>
    @State var roll: [Int] = []

    init(dices: [Int], total: Binding<Int>) {
        self.dices = dices
        self.total = total
    }

    var body: some View {
        VStack {
            ForEach(roll, id: \.self) { value in
                DiceView(value: value)
            }
        }
        .onAppear() {
            self.start()
        }
    }


    func start() {
        self.roll(with: 0)
    }

    func roll(with delay: Double) {
        if delay > 0.4 { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.roll = self.dices.map { Int.random(in: 1...$0 ) }
            self.total.wrappedValue = self.roll.reduce(0, +)
            self.roll(with: delay + 0.02)
        }
    }
}
