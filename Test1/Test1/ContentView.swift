//
//  ContentView.swift
//  Test1
//
//  Created by Dmytro Kholodov on 11/6/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

// ImagePaint struct

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20

    // How wide to make each petal
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()

        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)

            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))

            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)

            // add it to our main path
            path.addPath(rotatedPetal)
        }

        // now send the main path back
        return path
    }
}


struct ContentView_1: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0

    var body: some View {
        VStack {
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                .stroke(Color.red, lineWidth: 1)
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                //.fill(Color.red)
                .fill(Color.red, style: FillStyle(eoFill: true))

            Text("Offset")
            Slider(value: $petalOffset, in: -40...40).padding([.horizontal, .bottom])

            Text("Width")
            Slider(value: $petalWidth, in: 0...100).padding(.horizontal)
        }
    }
}

struct ContentView_2: View {


    var body: some View {
//        Text("Hello World")
//        .frame(width: 300, height: 300)
//        .background(Color.red)

//        Text("Hello World")
//        .frame(width: 300, height: 300)
//        .border(Color.red, width: 30)


//        Text("Hello World")
//        .frame(width: 300, height: 300)
//        .background(Image("Example"))

//        Text("Hello World")
//        .frame(width: 300, height: 300)
//        .border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)

//        Text("Hello World")
//        .frame(width: 300, height: 300)
//        .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
        Capsule()
        .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
        .frame(width: 300, height: 200)
    }
}


struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {

        ZStack {
            ZStack {
                ForEach(0..<steps) { value in
                    Circle()
                        .inset(by: CGFloat(value))
                        .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                            self.color(for: value, brightness: 1),
                            self.color(for: value, brightness: 0.5)
                        ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
                }
            }
        }
        .drawingGroup().drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}
struct ContentView_3: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
    }
}


struct ContentView : View {
    @State private var offset: CGSize = .zero
    @GestureState var isLongPressed = false

    var body: some View {
        let longPressAndDrag = LongPressGesture()
            .updating($isLongPressed) { value, state, transition in
                state = value
        }.simultaneously(with: DragGesture()
            .onChanged { self.offset = $0.translation }
            .onEnded { _ in self.offset = .zero }
        )

        return Circle()
            .fill(isLongPressed ? Color.purple : Color.red)
            .frame(width: 300, height: 300)
            .cornerRadius(8)
            .shadow(radius: 8)
            .padding()
            .scaleEffect(isLongPressed ? 1.1 : 1)
            .offset(x: offset.width, y: offset.height)
            .gesture(longPressAndDrag)
            .animation(.spring())
    }
}
