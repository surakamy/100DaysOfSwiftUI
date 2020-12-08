//
//  Country+CoreDataClass.swift
//  CoreDataProject
//
//  Created by Dmytro Kholodov on 12/8/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Country)
public class Country: NSManagedObject {
    public var wrappedShortName: String {
        shortName ?? "Unknown Country"
    }

    public var wrappedFullName: String {
        fullName ?? "Unknown Country"
    }
}
