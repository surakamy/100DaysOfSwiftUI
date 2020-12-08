//
//  Tag+CoreDataProperties.swift
//  RandomFriends
//
//  Created by Dmytro Kholodov on 12/11/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func request() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var name: String?
    @NSManaged public var taggedUsers: NSSet?

}

// MARK: Generated accessors for taggedUsers
extension Tag {

    @objc(addTaggedUsersObject:)
    @NSManaged public func addToTaggedUsers(_ value: User)

    @objc(removeTaggedUsersObject:)
    @NSManaged public func removeFromTaggedUsers(_ value: User)

    @objc(addTaggedUsers:)
    @NSManaged public func addToTaggedUsers(_ values: NSSet)

    @objc(removeTaggedUsers:)
    @NSManaged public func removeFromTaggedUsers(_ values: NSSet)

}
