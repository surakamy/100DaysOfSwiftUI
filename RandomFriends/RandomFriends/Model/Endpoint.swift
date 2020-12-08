//
//  User.swift
//  RandomFriends
//
//  Created by Dmytro Kholodov on 12/10/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import Foundation

enum EndpointUsers {
    public static var all: URL {
        URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
    }

    public struct User: Decodable, Identifiable {
        let id: UUID
        let isActive: Bool
        let name: String
        let age: Int
        let company: String
        let email: String
        let address: String
        let about: String
        let registered: String
        let friends: [Friend]
    }


    public struct Friend: Decodable, Identifiable {
        let id: UUID
        let name: String
    }

}
