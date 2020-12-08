//
//  Candy+CoreDataClass.swift
//  CoreDataProject
//
//  Created by Dmytro Kholodov on 12/8/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Candy)
public class Candy: NSManagedObject {
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}
