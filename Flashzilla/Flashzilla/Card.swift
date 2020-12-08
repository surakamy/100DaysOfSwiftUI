//
//  Card.swift
//  Flashzilla
//
//  Created by Dmytro Kholodov on 12/24/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String

    static var example: Card {
        return Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
