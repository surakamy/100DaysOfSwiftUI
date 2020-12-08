//
//  LayerMarkers.swift
//  Test
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct LayerMarkers: View {
    var body: some View {
        ZStack {
            LayerDirectionsMarkers()
                .foregroundColor(.white)

            LayerDirectionsDualMarkers()
                .foregroundColor(.white)
        }
    }
}

struct LayerMarkers_Previews: PreviewProvider {
    static var previews: some View {
        LayerMarkers()
    }
}
