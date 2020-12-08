//
//  ContentView.swift
//  SwiftUI-Sample
//
//  Created by Dmytro Kholodov on 10/18/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let counterMax = 10
    @State var counter = 10

    var timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
        .prefix(10)


    var body: some View {
        HStack {
            ForEach(0..<counterMax) { i in
                Rectangle().fill().frame(height: 1).foregroundColor(i < self.counter ? Color.blue : Color.clear)
            }
        }
        .onReceive(timer) { p in
            withAnimation {
                self.counter -= 1
            }

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
