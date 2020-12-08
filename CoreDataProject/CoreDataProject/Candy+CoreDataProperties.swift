//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Dmytro Kholodov on 12/8/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

}
