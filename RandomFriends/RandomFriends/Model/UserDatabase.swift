//
//  UserDatabase.swift
//  RandomFriends
//
//  Created by Dmytro Kholodov on 12/11/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import Foundation
import CoreData

struct UserDatabase {
    static func save(remoteUsers: [EndpointUsers.User], context: NSManagedObjectContext) {
        let allUsers = remoteUsers.reduce(into: [UUID:EndpointUsers.User]()) { result, next in
            result[next.id] = next
        }


        purgeDatabase()

        appendUsers(with: allUsers, context: context)


        if context.hasChanges {
            try! context.save()
        }
        
    }

    private static func purgeDatabase() {}

    private static func appendUsers(with data: [UUID:EndpointUsers.User], context: NSManagedObjectContext) {

        func appendOrFetchUser(by userValue: EndpointUsers.User) -> User {
            let fetchRequest = User.request()
            fetchRequest.predicate = NSPredicate(format: "id = %@", userValue.id.uuidString)
            let result = try! context.fetch(fetchRequest)

            if result.isEmpty {
                let user = User(context: context)
                user.id = userValue.id
                user.name = userValue.name
                user.email = userValue.email
                user.address = userValue.address
                user.about = userValue.about
                user.isActive = userValue.isActive
                user.company = appendOrFetchCompany(by: userValue.company)
                return user
            }

            return result.first!
        }

        func appendOrFetchCompany(by name: String) -> Company {
            let fetchRequest = Company.request()
            fetchRequest.predicate = NSPredicate(format: "name = %@", name)
            let result = try! context.fetch(fetchRequest)

            if result.isEmpty {
                let company = Company(context: context)
                company.name = name
                return company
            }

            return result.first!
        }

        func appendOrFetchTag(by name: String) -> Tag {
            let tag = Tag(context: context)
            tag.name = name
            return tag
        }

        for userValue in data.values {
            let user = appendOrFetchUser(by: userValue)

            for friendValue in userValue.friends {
                let friend = appendOrFetchUser(by: data[friendValue.id]!)
                user.addToFriends(friend)
            }
        }
    }
}
