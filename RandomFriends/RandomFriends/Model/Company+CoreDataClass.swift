//
//  Company+CoreDataClass.swift
//  RandomFriends
//
//  Created by Dmytro Kholodov on 12/11/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Company)
public class Company: NSManagedObject {
    public var wrappedName: String {
        name ?? "unknown"
    }

    public var wrappedEmployees: [User] {
        let set = employees as? Set<User> ?? []
        for s in set {
            print("\(s.name!)")
        }
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
