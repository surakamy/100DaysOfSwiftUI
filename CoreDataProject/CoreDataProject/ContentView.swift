//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Dmytro Kholodov on 12/7/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {

    enum PredicateWord: String {
        case beginsWith
        case contains
    }

    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, sortDescriptiors: [NSSortDescriptor], predicateWord: PredicateWord = .beginsWith, @ViewBuilder content: @escaping (T) -> Content) {
        print(NSPredicate(format: "%K \(predicateWord) %@", filterKey, filterValue))
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptiors, predicate: NSPredicate(format: "%K \(predicateWord) %@", filterKey, filterValue))
        self.content = content
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State var lastNameFilter = "A"

    var body: some View {
        VStack {
            // list of matching singers
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, sortDescriptiors: []) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }

            Button("Show A") {
                self.lastNameFilter = "A"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}


struct ContentView2: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }

            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


struct ContentView3: View {
    @Environment(\.managedObjectContext)
    var moc

    @FetchRequest(
        entity: Ship.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "universe == %@", "Star Wars"))
    var ships: FetchedResults<Ship>

    //NSPredicate(format: "name < %@", "F")) var ships: FetchedResults<Ship>
    //NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
    //NSPredicate(format: "name BEGINSWITH %@", "E"))
    //NSPredicate(format: "name BEGINSWITH[c] %@", "e"))
    //NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
    //NSCompoundPredicate

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
            }
        }
    }
}
