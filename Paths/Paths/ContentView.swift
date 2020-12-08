//
//  ContentView.swift
//  Paths
//
//  Created by Dmytro Kholodov on 11/5/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

/// InsettableShape
/// strokeBorder


struct ArrowHead: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX - 10, y: rect.minY - 10))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - 10, y: rect.minY - 10))

        return path
    }
}


extension Path {
    func point(at position: CGFloat) -> CGPoint {
        assert(position >= 0 && position <= 1)
        guard position > 0 else { return cgPath.currentPoint }
        return trimmedPath(from: 0, to: position).cgPath.currentPoint
    }
}

struct TurnArch: Shape, InsettableShape {
    /// Current heading of the compass
    var heading: Angle


    /// The heading to the target
    var target: Angle

    var offset: CGFloat // 0...1


    var head: ArrowHead = ArrowHead()

    var animatableData: AnimatablePair<CGFloat, ArrowHead.AnimatableData> {
        get {
            AnimatablePair(offset, head.animatableData)
        }
        set {
            offset = newValue.first
            head.animatableData = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        Path { p in

            let insetAdjusted: CGFloat = insetAmount * 2 / min(rect.width, rect.height)
            let rotationAdjustment = Angle.degrees(90)

            let endAngle = heading + (Angle.degrees(360) - heading) - rotationAdjustment
            let startAngle = endAngle + (target - heading)

            let clockDirection = startAngle.degrees > endAngle.degrees

            p.addArc(center: CGPoint(x: 0.5, y: 0.5), radius: 0.5 - insetAdjusted, startAngle: endAngle, endAngle: startAngle, clockwise: !clockDirection)
        }
        .trimmedPath(from: offset, to: 1) // to min(1, offset + 0.3)

        .applying(CGAffineTransform(scaleX: rect.width, y: rect.height))
    }


    var insetAmount: CGFloat = 0

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }

}

struct OnPath<P: Shape, S: Shape>: Shape {
    var shape: S
    let pathShape: P
    var offset: CGFloat // 0...1

    var animatableData: AnimatablePair<CGFloat, S.AnimatableData> {
        get {
            AnimatablePair(offset, shape.animatableData)
        }
        set {
            offset = newValue.first
            shape.animatableData = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        let path = pathShape.path(in: rect)
        let point = path.point(at: offset)
        let shapePath = shape.path(in: rect)
        let size = shapePath.boundingRect.size
        let head = shapePath.offsetBy(dx: point.x - size.width/2, dy: point.y - size.height/2)
        var result = Path()
        let trailLength: CGFloat = 0.1
        let trimFrom = offset - trailLength
        if trimFrom < 0 {
            result.addPath(path.trimmedPath(from: trimFrom + 1, to: 1).strokedPath(.init()))
        }
        result.addPath(path.trimmedPath(from: max(0, trimFrom), to: offset).strokedPath(.init()))
        result.addPath(head)
        return result
    }
}


struct ContentView: View {
    @State var arrowLength: CGFloat = 1
    @State var heading = Angle.degrees(0)
    @State var target = Angle.degrees(120)
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero

    @State var position: CGFloat = 0

    var body: some View {
        ZStack {
            Circle().foregroundColor(.blue)
            Circle().foregroundColor(.white).frame(width: 5).offset(x: 0, y: -130)
            TurnArch(heading: heading, target: target, offset: self.arrowLength)
            .strokeBorder(
                Color.yellow,
                style: StrokeStyle(
                    lineWidth: 10,
                    lineCap: .round))

            .frame(width: 300, height: 300)


            Circle().foregroundColor(.white).frame(width: 10)
        }.onTapGesture {
            let d = abs(self.heading.degrees - self.target.degrees)
            print(d)
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.heading = .degrees(Double.random(in: 0..<360))
                self.target = .degrees(Double.random(in: 0..<360))
                self.arrowLength = 0
            }

        }

        .frame(width: 320, height: 320)

//        .gesture(DragGesture().onEnded({ value in
//            self.newPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
//
//            let a = atan2(self.newPosition.height - 160, self.newPosition.width - 160)
//            print(a)
//
//
//            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
//                self.heading = .radians(Double(a))
//                self.target = .degrees(100)
//                self.arrowLength = 0
//            }
//        }))


        .onAppear() {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.arrowLength = 0
            }
        }



    }
}
