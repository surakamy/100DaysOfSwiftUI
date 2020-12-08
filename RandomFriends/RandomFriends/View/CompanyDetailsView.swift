//
//  CompanyDetailsView.swift
//  RandomFriends
//
//  Created by Dmytro Kholodov on 12/11/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct CompanyDetailsView: View {
    var company: Company
    var employees: [User] { company.wrappedEmployees }
    var body: some View {
        VStack() {
            Text("Company")
                .font(.largeTitle)
            Text(company.wrappedName)
                .fontWeight(.bold)
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text("Employees")
                    .font(.headline)
                    .padding(.leading)
                List(employees, id: \.id) { friend in
                    UserLink(user: friend )
                }
            }
        }

    }
}

//
//struct CompanyDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompanyDetailsView()
//    }
//}
