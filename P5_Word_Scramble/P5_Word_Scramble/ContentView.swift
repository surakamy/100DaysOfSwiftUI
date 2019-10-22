//
//  ContentView.swift
//  P5_Word_Scramble
//
//  Created by Dmytro Kholodov on 10/22/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

extension Character: Identifiable {
    public var id: Character { self }
}


struct WordView: View {
    var word: String

    var spelled: [Character] {
        Array(word)
    }

    var fontSize: CGFloat {
        CGFloat.random(in: 20...34)
    }

    var backgroundColor: Color {
        Color(red: Double.random(in: 0.4...1), green: Double.random(in: 0.4...1), blue: Double.random(in: 0.4...1))
    }

    var body: some View {
        HStack(alignment: .center) {
            ForEach(spelled) { c in
                Text(String(c))
                    .font(.system(size: self.fontSize))
                    .fontWeight(.black)
                    .padding(4)
                    .border(Color.black, width: 0.5)
                    .background(self.backgroundColor)
                    .rotationEffect(Angle(degrees: Double.random(in: -10...10)))
            }
        }

        .padding()

        .drawingGroup()
    }
}

struct ContentView: View {
    @State var allWords = ContentView.loadWords()

    @ObservedObject var search = SearchTextObservable()

    @State var isSearching = false

    var body: some View {
        NavigationView {
            List() {
                Section(header: EmptyView()) {
                    Text(search.searchText)
                    SearchField(searchTextWrapper: search, placeholder: "Any word?", isSearching: $isSearching)
                }

                Section(header: EmptyView()) {
                    ForEach(allWords) { w in
                        HStack {
                            Spacer()
                            WordView(word: w)
                            Spacer()
                        }
                    }
                }
            }
        }

        .onAppear {
            self.search.searchSubject.sink { s in
                print(s)
            }
        }
    }


    private static func loadWords() -> [String] {
        let resUrl = Bundle.main.url(forResource: "start", withExtension: "txt")
        let rawString = try! String(contentsOf: resUrl!)
        return rawString.split(separator: "\n").map(String.init)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
