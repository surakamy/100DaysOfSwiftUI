//
//  ContentView.swift
//  FaceMemos
//
//  Created by Dmytro Kholodov on 12/19/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    CoreData
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Person.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    var persons: FetchedResults<Person>

//  Modals
//    @State private var inputImage: UIImage?

    @State private var showingFaceDetails = false
    @State private var selectedFace: Person?

    var countTitle: String {
        let nf = NumberFormatter()
        nf.numberStyle = .spellOut
        return nf.string(from: NSNumber(value: persons.count)) ?? "Some"
    }
    var body: some View {
        NavigationView {
        VStack {
            VStack {
                Text(countTitle)
                .font(.system(size: 47))
                .fontWeight(.ultraLight)

                Text("Buddies".uppercased())
                .font(.largeTitle)
                .fontWeight(.black)
            }
            .foregroundColor(Color.red.opacity(0.75))
            .offset(x: 0, y: -50)
            //.padding()


            List(persons, id: \.self) { item in

                ZStack {
                    Image(uiImage: item.wrappedPhoto)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)

                    Text(item.wrappedName)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                    .offset(x: 0, y: 150)
                }.onTapGesture {
                    self.selectedFace = item
                    self.showingFaceDetails.toggle()
                }


            }


            Button(action: {
                self.selectedFace = nil
                self.showingFaceDetails.toggle()
            }) {
                Image(systemName: "plus")
                .padding(60)
                .background(Color.red.opacity(0.75))
                .foregroundColor(.white)
                .font(.largeTitle)
                .clipShape(Circle())
                .padding(.trailing)
            }
        }
        }.navigationBarTitle("", displayMode: .inline)

        .sheet(isPresented: $showingFaceDetails) {
            FaceView(person: self.$selectedFace, moc: self.moc)
        }

    }




}
