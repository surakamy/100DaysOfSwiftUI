//
//  ContentView.swift
//  Project11
//
//  Created by Dmytro Kholodov on 12/4/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct Row: View {
    let book: Book
    var body: some View {
        NavigationLink(destination: DetailView(book: book)) {
            EmojiRatingView(rating: book.rating)
                .font(.largeTitle)

            VStack(alignment: .leading) {
                Text(book.title ?? "Unknown Title")
                    .font(.headline)
                    .foregroundColor(book.rating == 1 ? Color.red : Color.primary)
                Text(book.author ?? "Unknown Author")
                    .foregroundColor(book.rating == 1 ? Color.red : Color.secondary)
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>

    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    Row(book: book)
                }
                .onDelete(perform: deleteBooks)
            }

                
                .navigationBarTitle("Bookworm")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
                }
        }
    }

    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let book = books[offset]

            // delete it from the context
            moc.delete(book)
        }

        // save the context
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
