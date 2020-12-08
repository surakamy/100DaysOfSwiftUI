//
//  LayerDirectionsMarkers.swift
//  Test
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct LayerDirectionsMarkers: View {
    private var labels: [Int: String] = [0: "N", 90: "E", 180: "S", 270: "W"]

    var body: some View {
        GeometryReader { geo in
            ZStack {

                ForEach(Array(stride(from: 0, to: 360, by: 90)), id: \.self) { turn in

                    Marker(label: "\(self.direction(degree: turn != 0 ? 360 - turn : 0))", north: self.isNorth(degree: turn))
                        .rotationEffect(Angle(degrees: -turn + 90))
                        .offset(self.offset(with: Angle(degrees: turn), geo: geo))

                }
            }
        }

        .rotationEffect(Angle(degrees: -90))
        .drawingGroup()
    }

    private func isNorth(degree: Double) -> Bool { Int(degree) == 0 }

    private func direction(degree: Double) -> String {
        labels[Int(degree)] ?? ""
    }

    private func radius(with geo: GeometryProxy, offset: CGFloat = 0) -> CGFloat {
        geo.size.height / 2 + offset
    }

    private func offset(with angle: Angle, geo: GeometryProxy) -> CGSize {
        CGSize(
            width: (CGFloat(cos(angle.radians)) * self.radius(with: geo, offset: isNorth(degree: angle.degrees) ? -20 : -40)),
            height: -(CGFloat(sin(angle.radians)) * self.radius(with: geo, offset: isNorth(degree: angle.degrees) ? -20 : -40))
        )
    }
}

struct Marker: View {
    var label: String
    var north: Bool
    @Environment(\.sizeCategory) var sizeCategory
    let colFront = Color(#colorLiteral(red: 0, green: 0.1506882608, blue: 0.2586770654, alpha: 1))
    @ViewBuilder
    var body: some View {
        Text(label)
            .fontWeight(.light)
            .padding(10)
            .frame(alignment: .top)
            .background(north ? Color.red : colFront)
            .foregroundColor(Color.white)
            .clipShape(
                Circle()
            )
//        if north {
//            Text(label)
//                .padding(10)
//                .foregroundColor(.white)
//                .background(Color.red)
//                .clipShape(
//                    Circle()
//                )
//        } else {
//            if sizeCategory < .accessibilityLarge {
//                Text(label)
//                .foregroundColor(.white)
//                .fontWeight(.light)
//            } else {
//                Text(label)
//                .padding(10)
//                .fontWeight(.light)
//                .background(Color.white)
//                .foregroundColor(colFront)
//                .clipShape(
//                    Circle()
//                )
//            }
//        }
    }
}



struct LayerDirectionsMarkers_Previews: PreviewProvider {
    static var previews: some View {
        LayerDirectionsMarkers()
    }
}
