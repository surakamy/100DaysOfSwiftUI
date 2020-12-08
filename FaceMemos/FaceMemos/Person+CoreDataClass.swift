//
//  Person+CoreDataClass.swift
//  FaceMemos
//
//  Created by Dmytro Kholodov on 12/19/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    var wrappedName: String { self.name ?? "" }
    var wrappedPhoto: UIImage { self.photo as? UIImage ?? UIImage() }
}




