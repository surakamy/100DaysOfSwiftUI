//
//  DiceView.swift
//  RollDicied
//
//  Created by Dmytro Kholodov on 12/29/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    var value: Int
    var backColor = UIColor.red


    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(backColor.darker()!))

            RoundedRectangle(cornerRadius: 7)
                .foregroundColor(Color(backColor))
                .padding(5)

            Text(String(value))
                .font(.system(size: 80))
                .foregroundColor(Color(backColor.darker(by: 60)!))
                .shadow(radius: 2)
        }
        .frame(width: 120, height: 120)
        .rotationEffect(Angle(degrees: Double.random(in: -1...1)))


    }
}
