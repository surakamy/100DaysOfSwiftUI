//
//  Person+CoreDataProperties.swift
//  FaceMemos
//
//  Created by Dmytro Kholodov on 12/19/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var photo: NSObject?

}
