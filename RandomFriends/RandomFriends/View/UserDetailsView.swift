//
//  UserDetailsView.swift
//  RandomFriends
//
//  Created by Dmytro Kholodov on 12/10/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct UserDetailsView: View {
    var user: User
    var hasCompany: Bool { user.company != nil }
    var body: some View {
        VStack() {
            Text("User")
                .font(.largeTitle)

            Text(user.wrappedName)
                .fontWeight(.bold)
                .font(.largeTitle)

            if hasCompany {
                NavigationLink(destination: CompanyDetailsView(company: user.company!)) {
                    Text(user.wrappedCompanyName)
                }
            }



//            Text(user.email)
//            Text(user.address)
            VStack(alignment: .leading) {
                Text("Friends")
                    .font(.headline)
                    .padding(.leading)
                List(user.wrappedFriends) { friend in
                    UserLink(user: friend )
                }
            }
        }
    }
}

//struct UserDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailsView(user: )
//    }
//}
