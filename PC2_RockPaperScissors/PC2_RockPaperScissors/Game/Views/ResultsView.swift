//
//  ResultsView.swift
//  PC2_RockPaperScissors
//
//  Created by Dmytro Kholodov on 10/18/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
    var score: Int
    var total: Int
    var show: Bool

    var body: some View {

        VStack(spacing: 0) {
            Text(show ? "\(score)" : "-")
                .font(.system(size: 100))

            Rectangle().fill().frame(width: 200, height: 9)

            Text(show ? "\(total)" : "-")
                .font(.system(size: 100))
        }


        .foregroundColor(.yellow)

        .padding(50)
        .background(Color.blue)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.yellow, lineWidth: 8))
    }
}
