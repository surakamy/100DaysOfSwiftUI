//
//  ContentView.swift
//  Meetups
//
//  Created by Dmytro Kholodov on 12/22/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var prospects = Prospects()

    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }.environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
