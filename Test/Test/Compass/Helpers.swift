//
//  Helpers.swift
//  Test
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

extension CGPoint {
    func offseted(byX: CGFloat = 0, byY: CGFloat = 0) -> CGPoint {
        CGPoint(x: x + byX, y: y + byY)
    }
}

extension CGRect {
    var center: CGPoint { CGPoint(x: midX, y: midY) }
}

extension CGSize {
    var center: CGPoint { CGPoint(x: width/2, y: height/2) }
}


extension ContentSizeCategory: Comparable {
    public static func < (lhs: ContentSizeCategory, rhs: ContentSizeCategory) -> Bool {
        let lhsIndex = allCases.firstIndex(of: lhs) ?? -1
        let rhsIndex = allCases.firstIndex(of: rhs) ?? -1

        return lhsIndex < rhsIndex
    }
}

