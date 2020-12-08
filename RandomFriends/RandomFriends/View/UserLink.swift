//
//  UserLink.swift
//  RandomFriends
//
//  Created by Dmytro Kholodov on 12/10/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct UserLink: View {
    var user: User
    var body: some View {
        NavigationLink(destination: UserDetailsView(user: user)) {
            Text(user.wrappedName)
                .font(.headline)
            Text("from")
            Text(user.wrappedCompanyName)
        }
    }
}

//struct UserLink_Previews: PreviewProvider {
//    static var previews: some View {
//        UserLink()
//    }
//}
