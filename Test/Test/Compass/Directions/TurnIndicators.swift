//
//  TurnIndicators.swift
//  Test
//
//  Created by Dmytro Kholodov on 11/4/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI


struct TurnArrow: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { p in
//            let start = CGPoint(x: 0.5, y: 0.5)
//            p.move(to: start)
            p.addEllipse(in: CGRect(x: 0, y: 0, width: 1, height: 1))

        }.applying(CGAffineTransform(scaleX: rect.width, y: rect.height))
    }
}
