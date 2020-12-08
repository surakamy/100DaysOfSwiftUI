//
//  ContentView.swift
//  RollDicied
//
//  Created by Dmytro Kholodov on 12/29/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewRollTabView()
            .tabItem {
                Image(systemName: "plus")
                Text("Roll")
            }

            HistoryRollTab()
            .tabItem {
                Image(systemName: "clock")
                Text("History")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
