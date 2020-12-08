//
//  ContentView.swift
//  PixelBoard
//
//  Created by Dmytro Kholodov on 10/26/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

extension UIColor {
    static var random: UIColor {
        UIColor(
            red: CGFloat.random(in: 0.7...1),
            green: CGFloat.random(in: 0.7...1),
            blue: CGFloat.random(in: 0.7...1),
            alpha: 1)
    }

    static var randomBlue: UIColor {
        UIColor(
            red: 0,
            green: 0,
            blue: CGFloat.random(in: 0.5...0.9),
            alpha: 1)
    }

    static var randomRed: UIColor {
        UIColor(
            red: CGFloat.random(in: 0.5...0.9),
            green: 0,
            blue: 0,
            alpha: 1)
    }

    static var randomGreen: UIColor {
        UIColor(
            red: 0,
            green: CGFloat.random(in: 0.5...0.9),
            blue: 0,
            alpha: 1)
    }
}

struct Pixel: View {
    var color: UIColor
    var body: some View {
        Color(color)
        .frame(width: 25, height: 25)
        .clipShape(RoundedRectangle(cornerRadius: 3))
            //.aspectRatio(1, contentMode: .fit)
    }
}


struct GridView<Content: View>: View {
    var rows: Int
    var columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<self.columns, id: \.self) { column in
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



struct ContentView: View {

    let maxRows = 25
    @State var elements = 10

    var body: some View {

        ZStack {
            HStack(spacing: 1) {

                GridView(rows: min(elements, maxRows), columns: 5) { _, _ in
                    Pixel(color: UIColor.randomRed)
                }.scaledToFit()


                GridView(rows: min(elements, maxRows), columns: 5) { _, _ in
                    Pixel(color: UIColor.randomBlue)
                }.scaledToFit()

                GridView(rows: min(elements, maxRows), columns: 5) { _, _ in
                    Pixel(color: UIColor.randomGreen)
                }.scaledToFit()

            }

            .drawingGroup(opaque: false, colorMode: .linear)

            //.clipShape(Circle())

        }


        .onTapGesture {
            withAnimation(.interpolatingSpring(stiffness: 50, damping: 1)) {
                self.elements += 1
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
