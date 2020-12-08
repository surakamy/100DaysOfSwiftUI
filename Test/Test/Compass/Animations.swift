//
//  ContentView.swift
//  ArrowAnimation
//
//  Created by Chris Eidhof on 01.08.19.
//  Copyright © 2019 Chris Eidhof. All rights reserved.
//

import SwiftUI

struct Eight: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { p in
            let start = CGPoint(x: 0.75, y: 0)
            p.move(to: start)
            p.addQuadCurve(to: CGPoint(x: 1, y: 0.5), control: CGPoint(x: 1, y: 0))
            p.addQuadCurve(to: CGPoint(x: 0.75, y: 1), control: CGPoint(x: 1, y: 1))
            p.addCurve(to: CGPoint(x: 0.25, y: 0), control1: CGPoint(x: 0.5, y: 1), control2: CGPoint(x: 0.5, y: 0))
            p.addQuadCurve(to: CGPoint(x: 0, y: 0.5), control: CGPoint(x: 0, y: 0))
            p.addQuadCurve(to: CGPoint(x: 0.25, y: 1), control: CGPoint(x: 0, y: 1))
            p.addCurve(to: start, control1: CGPoint(x: 0.5, y: 1), control2: CGPoint(x: 0.5, y: 0))
        }.applying(CGAffineTransform(scaleX: rect.width, y: rect.height))
    }
}

extension Path {
    func point(at position: CGFloat) -> CGPoint {
        assert(position >= 0 && position <= 1)
        guard position > 0 else { return cgPath.currentPoint }
        return trimmedPath(from: 0, to: position).cgPath.currentPoint
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

struct DemoView: View {

    @State var position: CGFloat = 0

    var body: some View {


        VStack {
            ZStack {
                Eight()
                    .stroke(Color.gray)
                OnPath(shape: Rectangle().size(width: 10, height: 10), pathShape: Eight(), offset: position)
                    .foregroundColor(.black)
                .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
            }.onAppear(perform: {
                self.position = 1
            })
            .aspectRatio(16/9, contentMode: .fit)
            .padding(20)
        }

    }
}
