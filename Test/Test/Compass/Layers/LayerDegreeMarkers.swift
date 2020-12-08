//
//  LayerDegreeMarkers.swift
//  Test
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct LayerDegreeMarkers: View {

    var body: some View {
        GeometryReader { geo in
            ZStack {

                ForEach(Array(stride(from: 0, to: 360, by: 20)), id: \.self) { turn in
                    Text("\(turn != 0 ? 360 - turn : 0, specifier: "%.0f")")
                        .rotationEffect(Angle(degrees: -turn + 90))
                        .offset(
                            x: (CGFloat(cos(Angle(degrees: turn).radians)) * self.radius(with: geo, offset: -9)),
                            y: -(CGFloat(sin(Angle(degrees: turn).radians)) * self.radius(with: geo, offset: -9)))

                }
            }
        }

        .rotationEffect(Angle(degrees: -90))
    }

    private func radius(with geo: GeometryProxy, offset: CGFloat = 0) -> CGFloat {
        geo.size.height / 2 + offset
    }
}


//struct Marker: View {
//    var label: String
//    var north: Bool
//    @Environment(\.sizeCategory) var sizeCategory
//    let colFront = Color(#colorLiteral(red: 0, green: 0.1506882608, blue: 0.2586770654, alpha: 1))
//    @ViewBuilder
//    var body: some View {
//        if north {
//            Text(label)
//                .padding(10)
//                .foregroundColor(.white)
//                .background(Color.red)
//                .clipShape(
//                    Circle()
//                )
//        } else {
//
//            if sizeCategory < .accessibilityLarge {
//                Text(label)
//                .foregroundColor(.white)
//                .fontWeight(.light)
//            } else {
//                Text(label)
//                .padding(10)
//                .background(Color.white)
//                .foregroundColor(colFront)
//                .clipShape(
//                    Circle()
//                )
//            }
//        }
//    }
//}


struct LayerDegreeMarkers_Previews: PreviewProvider {
    static var previews: some View {
        LayerDegreeMarkers()
    }
}
