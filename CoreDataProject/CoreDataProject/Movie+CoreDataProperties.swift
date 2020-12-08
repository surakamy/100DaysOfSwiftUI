//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Dmytro Kholodov on 12/7/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

}

/*

 if self.moc.hasChanges {
     try? self.moc.save()
 }
 
 */
