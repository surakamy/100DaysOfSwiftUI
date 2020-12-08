//
//  ContentView.swift
//  Multiplication
//
//  Created by Dmytro Kholodov on 10/29/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct GameAskQuestion: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Question()

            Spacer()

            GridView(rows: 2, columns: 2) { _, _ in
                Answer()
            }
        }
    }
}

struct ContentView: View {
    @State var visible = false
    var body: some View {

        VStack {


            if visible {
                GameAskQuestion()
                    .transition(.move(edge: .bottom))
            } else {
                Button(action: {
                    withAnimation {
                        self.visible = true
                    }
                }) {
                    Text("PLAY")
                }
            }
        }
    }
}


struct _ContentView: View {
    @State var showDetails = false

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    self.showDetails.toggle()
                }
            }) {
                Text("Tap to show details")
            }

            if showDetails {
                Text("Details go here.")
                    .transition(.slide)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
