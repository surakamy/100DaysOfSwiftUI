//
//  ButtonStyles.swift
//  PC2_RockPaperScissors
//
//  Created by Dmytro Kholodov on 10/18/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct PressedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}



struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.yellow, lineWidth: 5))
            .shadow(color: .yellow, radius: 2)
            .foregroundColor(.yellow)

            .buttonStyle(PressedButtonStyle())
    }
}
