//
//  LayerCompassCenter.swift
//  Test
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct LayerCompassCenter: View {
    var body: some View {
        Circle()
            .foregroundColor(.black)
            .frame(width: 40)
//        Circle()
//            .frame(width: 20)
    }
}

struct LayerCompassCenter_Previews: PreviewProvider {
    static var previews: some View {
        LayerCompassCenter()
    }
}
