//
//  MenuView.swift
//  PC2_RockPaperScissors
//
//  Created by Dmytro Kholodov on 10/18/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var game: Game

    var body: some View {
        VStack {

            ResultsView(score: game.score, total: game.total, show: game.wasPlayed)

            Spacer()

            RulesView(game: game)



            Button(action: game.reset ) {
                Text("PLAY")
                    .padding()
                    .padding(.leading, 50)
                    .padding(.trailing, 50)
                    .font(.largeTitle)
            }

            .buttonStyle(MenuButtonStyle())
        }
    }
}
