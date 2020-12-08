//
//  ContentView.swift
//  Expenses
//
//  Created by Dmytro Kholodov on 10/30/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }


                Button("Add Number") { self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }

                Button("Show Sheet") {
                    self.showingSheet.toggle()
                }
            }

            .navigationBarItems(leading: EditButton())

        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@surakamy")
        }

    }

    func removeRows(at offsets: IndexSet) { numbers.remove(atOffsets: offsets)
    }

}

struct SecondView: View {
    var name: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Hello, \(name)!")
            Button("Dismiss") { self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
