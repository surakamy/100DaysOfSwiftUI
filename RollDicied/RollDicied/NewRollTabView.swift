//
//  NewRollTabView.swift
//  RollDicied
//
//  Created by Dmytro Kholodov on 12/29/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct NewRollTabView: View {
    @State var total: Int = 0
    @State var reroll: Bool = false
    @State var dices = [6, 6, 6]

    var body: some View {
        ZStack {
            Color.black
            VStack {
                RollView(dices: dices, total: $total)
                TotalView(value: self.total)
            }
        }
    }
}
