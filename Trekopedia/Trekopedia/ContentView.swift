//
//  ContentView.swift
//  Trekopedia
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

import CoreData

struct DetailView: View {
    var community: MCCommunity
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Text(self.community.name ?? "")
                        .font(.headline)
                        .padding()
                    Text(self.community.context ?? "")
                        .font(.subheadline)
                        .padding()
                    //                    Text(self.community.summary ?? "")
                    //                        .font(.body)
                }
                Spacer(minLength: 25)
                VStack(alignment: .leading) {
                    ForEach(self.community.attributes?.allObjects as! [MCAttribute], id: \.self) { attr in
                        HStack {
                            Image(systemName: "rosette")
                                .font(.largeTitle).foregroundColor(.blue)
                            Text(attr.name ?? "")
                        }.padding(.vertical)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }

        // .navigationBarTitle(self.community.type?.name ?? "", displayMode: .inline)
    }
}

struct Row: View {
    var community: MCCommunity

    @State var scaled: CGFloat = 0.8

    var body: some View {
        HStack {
            Circle()
                .frame(width: 10)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(community.name ?? "Unknown")
                    .font(.headline)
                    .lineLimit(nil)
                    .layoutPriority(1)
                Text(community.context ?? "Unknown")
                    .font(.subheadline)
                    .lineLimit(nil)
                    .layoutPriority(1)
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text(community.type?.name ?? "Unknown")
                        .padding(.horizontal, 5)
                        .font(.footnote)
                        .lineLimit(1)
                        .background(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                        .clipShape(Capsule())
                        .layoutPriority(1)

                    if community.population?.intValue ?? 0 > 0 {
                        HStack(alignment: .lastTextBaseline, spacing: 0) {
                            Image(systemName: "person.fill")
                            Text("\(community.population ?? 0)")
                        }
                        .padding(.horizontal, 5)
                        .font(.footnote)
                            .lineLimit(1)
                        .background(Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)))
                        .clipShape(Capsule())
                        .layoutPriority(1)
                    }

                    if community.altitude?.intValue ?? 0 > 0 {

                        HStack(spacing: 0) {
                            Image(systemName: "arrow.up")
                            Text("\(community.altitude ?? 0) m")
                        }
                        .padding(.horizontal, 5)
                        .font(.footnote)
                            .lineLimit(1)
                        .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                        .clipShape(Capsule())
                        .layoutPriority(1)
                    }
                }
                .foregroundColor(.white)
                .layoutPriority(2)
            }

            .navigationBarTitle("C2C Communities")
        }

        .scaleEffect(self.scaled)
        .animation(.default)
        .drawingGroup()

        .onAppear() {
            self.scaled += 0.2
        }

        .onDisappear() {
            self.scaled -= 0.2
        }

//        .onTapGesture {
//            withAnimation(Animation.default.repeatCount(2, autoreverses: true)) {
//                self.scaled = 0.8
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
//                    self.scaled = 1.0
//                }
//            }
//        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        entity: MCCommunity.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \MCCommunity.order, ascending: true)
        ]
    ) var communities: FetchedResults<MCCommunity>

    var body: some View {
        NavigationView {
            List() {

                ForEach(communities, id: \.self) { item in
                    NavigationLink(destination: DetailView(community: item)) {
                Row(community: item)
                   // .frame(minWidth: .greatestFiniteMagnitude)
                }
            }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
