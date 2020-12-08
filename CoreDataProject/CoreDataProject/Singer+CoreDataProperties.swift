//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Dmytro Kholodov on 12/8/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
    
}
