//
//  ContentView.swift
//  PC2_RockPaperScissors
//
//  Created by Dmytro Kholodov on 10/18/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var game = Game()

    var body: some View {

        ZStack {
            AngularGradient(gradient: Gradient(colors: [Color.purple,  .blue]), center: .topTrailing)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
            VStack() {
                ProgressView(current: game.score, total: game.total, answers: game.answers)


                if game.gameOver {
                    MenuView(game: game)
                } else {
                    GameView(game: game)
                }
            }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
