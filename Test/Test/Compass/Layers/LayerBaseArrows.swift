//
//  LayerBaseArrows.swift
//  Test
//
//  Created by Dmytro Kholodov on 11/3/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct LayerBaseArrows: View {
    let colFront = Color(#colorLiteral(red: 0, green: 0.1506882608, blue: 0.2586770654, alpha: 1))
    let colBaseArrow = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    var body: some View {
        ZStack {
            LayerBaseArrow()
                .rotationEffect(Angle(degrees: 0))
                .foregroundColor(colBaseArrow)
            LayerBaseArrow()
                .rotationEffect(Angle(degrees: -90))
                .foregroundColor(colBaseArrow)

            LayerBaseArrow()
                .rotationEffect(Angle(degrees: 45))
                .foregroundColor(colBaseArrow)
            LayerBaseArrow()
                .rotationEffect(Angle(degrees: -45))
                .foregroundColor(colBaseArrow)
        }
    }
}


private struct LayerBaseArrow: View {
    var body: some View {
        BaseArrow(length: 1.0, turn: 0.0)
            .stroke()
    }
}

private struct BaseArrow: Shape {
    let length: CGFloat
    let turn: Double

    func path(in rect: CGRect) -> Path {
        return Path { p in
//            let radiusStart: CGFloat = 0.5
//            let radiusFinish: CGFloat = radiusStart - length
            let center = CGPoint(x: 0.5, y: 0.5)


            let half: CGFloat = 0.04
//            p.move(to: center.offseted(byX: -half))
//            p.addLine(to: center.offseted(byY: -0.35))
//            p.addLine(to: center.offseted(byX: half))
//            p.addLine(to: center.offseted(byY: 0.35))
//            p.addLine(to: center.offseted(byX: -half))


            p.move(to: center.offseted(byY: -half))
            p.addLine(to: center.offseted(byX: -0.35))
            p.addLine(to: center.offseted(byY: half))
            p.addLine(to: center.offseted(byX: 0.35))
            p.addLine(to: center.offseted(byY: -half))
        }
        .applying(CGAffineTransform(scaleX: rect.width, y: rect.height))
    }
}


struct LayerBaseArrows_Previews: PreviewProvider {
    static var previews: some View {
        LayerBaseArrows()
    }
}
