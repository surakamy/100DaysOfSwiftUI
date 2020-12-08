//
//  LayerDegressTicks.swift
//  Test
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct LayerDegressTicks: View {
    var body: some View {
        ZStack {
            ClockTicks(length: 0.03, turn: 2)
                .stroke(lineWidth: 1)

            ClockTicks(length: 0.05, turn: 10)
                .stroke(lineWidth: 1)

            ClockTicks(length: 0.07, turn: 90)
                .stroke(lineWidth: 1)
        }
            .padding()
            .foregroundColor(.white)
    }
}

private struct ClockTicks: Shape {
    let length: CGFloat
    let turn: Double

    func path(in rect: CGRect) -> Path {
        return Path { p in
            let radiusStart: CGFloat = 0.5
            let radiusFinish: CGFloat = radiusStart - length
            let center = CGPoint(x: 0.5, y: 0.5)

            for turn in stride(from: 0.0, to: 360.0, by: turn) {
                let turnInRad = Angle(degrees: turn).radians

                let pointStart = CGPoint(
                    x: CGFloat(cos(turnInRad)) * radiusStart + center.x,
                    y: CGFloat(sin(turnInRad)) * radiusStart + center.y)

                let pointFinish = CGPoint(
                    x:CGFloat(cos(turnInRad)) * radiusFinish + center.x,
                    y: CGFloat(sin(turnInRad)) * radiusFinish + center.y)

                p.move(to: pointStart)
                p.addLine(to: pointFinish)
            }

        }.applying(CGAffineTransform(scaleX: rect.width, y: rect.height))
    }
}

struct LayerDegressTicks_Previews: PreviewProvider {
    static var previews: some View {
        LayerDegressTicks()
    }
}
