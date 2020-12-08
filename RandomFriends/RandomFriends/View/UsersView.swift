//
//  UsersView.swift
//  RandomFriends
//
//  Created by Dmytro Kholodov on 12/10/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI
import Combine

struct UsersView: View {
    @Environment(\.managedObjectContext) var moc

    @State var results = [EndpointUsers.User]()
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>

    var body: some View {
        NavigationView {
            List(users) { user in
                VStack(alignment: .leading) {
                    UserLink(user: user)
                }
            }
        }

        .onReceive(loader) { results in
            UserDatabase.save(remoteUsers: results, context: self.moc)
            self.results = []
        }
    }


    var loader = URLSession
        .shared
        .dataTaskPublisher(for: EndpointUsers.all)
        .map { $0.data }
        .decode(type: [EndpointUsers.User].self, decoder: JSONDecoder())
        .catch { _ in Just([]) }
        .receive(on: RunLoop.main)

}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
