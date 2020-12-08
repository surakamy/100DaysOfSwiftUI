//
//  LayerDirectionsDualMarkers.swift
//  Test
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct LayerDirectionsDualMarkers: View {
    private var labels: [Int: String] = [45: "NE", 135: "SE", 225: "SW", 315: "NW"]
    var body: some View {
        GeometryReader { geo in
            ZStack {

                ForEach(Array(stride(from: 45, to: 360, by: 90)), id: \.self) { turn in

                    Marker(label: "\(self.direction(degree: Int(turn != 0 ? 360 - turn : 0)))", north: Int(turn) == 0)
                        .rotationEffect(Angle(degrees: -turn + 90))
                        .offset(
                            x: (CGFloat(cos(Angle(degrees: turn).radians)) * self.radius(with: geo, offset: -50)),
                            y: -(CGFloat(sin(Angle(degrees: turn).radians)) * self.radius(with: geo, offset: -50)))

                }
            }
        }

        .rotationEffect(Angle(degrees: -90))
        .drawingGroup()
    }

    private func direction(degree: Int) -> String {
        labels[degree] ?? ""
    }
    private func radius(with geo: GeometryProxy, offset: CGFloat = 0) -> CGFloat {
        geo.size.height / 2 + offset
    }
}

struct LayerDirectionsDualMarkers_Previews: PreviewProvider {
    static var previews: some View {
        LayerDirectionsDualMarkers()
    }
}
