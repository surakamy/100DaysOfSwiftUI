//
//  ContentView.swift
//  SwiftUIChart
//
//  Created by Dmytro Kholodov on 10/28/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct Bar: View {
    @State var value = 0.0
    @State var stretched = 0.0


    let base = 10.0
    let maxStretching = 300.0

    var body: some View {
        RoundedRectangle(cornerRadius: 2)

            .foregroundColor(.blue)

            .frame(height: CGFloat(value + stretched + base))

            .gesture(
                DragGesture()

                .onChanged{ gesture in
                    let delta = Double(gesture.location.y)
                    self.stretched = max(0, min(self.stretched - delta, self.maxStretching))
                }
            )
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                ForEach(1..<10) { v in
                    Bar(value: 20.0)
                        .frame(width: 25)
                }.rotation3DEffect(Angle(degrees: 10), axis: (x: 1, y: 1, z: 0))

        }
    }

    .padding(100)
    }
}



struct _ContentView: View {
    // 1.
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero

    var body: some View {
        // 2.
        Circle()
            .frame(width: 100, height: 100)
            .foregroundColor(Color.red)
            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
            // 3.
            .gesture(DragGesture()
                .onChanged { value in
                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
            }   // 4.
                .onEnded { value in
                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                    print(self.newPosition.width)
                    self.newPosition = self.currentPosition
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
