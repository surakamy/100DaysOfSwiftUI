//
//  GameView.swift
//  PC2_RockPaperScissors
//
//  Created by Dmytro Kholodov on 10/18/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: Game

    
    
    var body: some View {
        VStack {
            ZStack {
                Text(String(describing: game.currentMove))
                    .font(.system(size: 300))
                    .shadow(color: .white, radius: 20)
                
                
                Text("\(game.currentGoal.description)")
                    .font(.system(size: 50))
                    .foregroundColor(game.currentGoal == .win ? Color.green : Color.red)
                    .padding()
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .border(game.currentGoal == .win ? Color.green : Color.red, width: 5)
                    .rotationEffect(Angle(degrees: -45), anchor: .center)
                    .shadow(color: .black, radius: 2)
                
            }
            
            Spacer(minLength: 100)

            //ScrollView(.horizontal) {
                HStack(spacing: 2) {
                    ForEach(game.possibleMoves, id: \.self) { item in
                        Button(action: {
                            withAnimation { self.game.move(with: item) } }) {
                            Text("\(item.description)")
                                .font(.system(size: 80))
                                .shadow(color: .white, radius: 10)
                        }
                    }
                }
            //}
        }
    }
}
