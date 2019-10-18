//
//  RulesView.swift
//  PC2_RockPaperScissors
//
//  Created by Dmytro Kholodov on 10/18/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI



struct RulesView: View {
    @ObservedObject var game: Game
    
    func values(_ item: Item) -> String {
        guard let beaten = game.rules[item] else { return "" }
        let beatenItems = beaten.map(String.init(describing:))
        let lf = ListFormatter()
        return lf.string(from: beatenItems) ?? ""
    }
    
    var body: some View {

        VStack(alignment: .leading, spacing: 10) {
            ForEach(Array(game.rules.keys), id: \.self) { rule in
                HStack(alignment: .firstTextBaseline) {
                    Text(String(describing: rule))
                    Text("beats")
                    Text(self.values(rule))
                }
            }
        }
        .font(.system(size: 28))
        .padding()
        .foregroundColor(.white)
        
    }
}
