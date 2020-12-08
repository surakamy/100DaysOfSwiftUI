//
//  Company+CoreDataProperties.swift
//  RandomFriends
//
//  Created by Dmytro Kholodov on 12/11/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func request() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var employees: NSSet?

}

// MARK: Generated accessors for employees
extension Company {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: User)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: User)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}
