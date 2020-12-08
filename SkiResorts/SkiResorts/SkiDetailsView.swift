//
//  SkiDetailsView.swift
//  SkiResorts
//
//  Created by Dmytro Kholodov on 12/31/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort

    var body: some View {
        VStack {
            Text("Elevation: \(resort.elevation)m")
            Text("Snow: \(resort.snowDepth)cm")
        }
    }
}
