//
//  ScoreView.swift
//  PC2_RockPaperScissors
//
//  Created by Dmytro Kholodov on 10/18/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI


struct ProgressView: View {
    var current: Int
    var total: Int
    var answers: [Bool]

    var body: some View {
        VStack {
            Text(##"["Rock", "Paper", "Scissors"]"##)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.headline)
                .padding(.top, 20)

            HStack {
                ForEach(0..<total) { number in
                    if self.answers.count > number {
                        Circle()
                            .frame(height: 30)
                            .foregroundColor(self.answers[number] ? Color.green : Color.red)
                            .overlay(Circle()
                            .stroke(Color.white, lineWidth: 1))
                    } else {
                        Circle()
                            .frame(height: 30)
                            .foregroundColor(.white)
                    }
                }
            }

            .padding(.leading, 50)
            .padding(.trailing, 50)
        }.foregroundColor(.white)
    }
}
