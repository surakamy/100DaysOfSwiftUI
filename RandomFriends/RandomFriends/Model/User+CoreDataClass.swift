//
//  User+CoreDataClass.swift
//  RandomFriends
//
//  Created by Dmytro Kholodov on 12/11/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Identifiable {
    public var wrappedName: String {
        name ?? "unknown"
    }

    public var wrappedCompanyName: String {
        company?.name ?? "unemployed"
    }

    public var wrappedFriends: [User] {
        let set = friends as? Set<User> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
