//
//  GridVIew.swift
//  P2_GuessTheFlag
//
//  Created by Dmytro Kholodov on 10/16/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct GridView<Content: View>: View {
    var rows: Int
    var columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows) { row in
                HStack {
                    ForEach(0..<self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}


struct BoardView<Content: View>: View {
    var rows: Int
    var columns: Int
    let content: (Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows) { row in
                HStack {
                    ForEach(0..<self.columns) { column in
                        self.content(row*self.columns + column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
