//
//  CompassView.swift
//  Test
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct CompassView: View {
    @State var position: CGFloat = 0
    @State var heading = 0.0
    let colFront = Color(#colorLiteral(red: 0, green: 0.1506882608, blue: 0.2586770654, alpha: 1))
    let colBaseArrow = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    @Environment(\.sizeCategory) var sizeCategory

    var directionCircle: TurnArrow {
        TurnArrow()
    }
    var body: some View {
        ZStack {

            LayerCompassDisk()
                .foregroundColor(colFront)

            LayerDegressTicks()

            if sizeCategory < .accessibilityLarge {
                LayerDegreeMarkers()
                    .foregroundColor(.white)
            }


            LayerBaseArrows()

            LayerMarkers()


            LayerCompassCenter()

            directionCircle.scale(1.05).stroke(Color.yellow, lineWidth: 10)

            OnPath(shape: Rectangle().size(width: 10, height: 10), pathShape: directionCircle.scale(1.05), offset: position)
                .foregroundColor(.black)
            .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
        }
        .padding()
        .aspectRatio(1, contentMode: .fit)
        .drawingGroup()
        .rotationEffect(Angle(degrees: heading))
        .animation(
            Animation.default
                .speed(0.1) )
//                .repeatForever(autoreverses: true))

        .onAppear() {
            //self.heading = -30
            self.position = 1
        }
    }
}
