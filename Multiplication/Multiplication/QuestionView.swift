//
//  QuestionView.swift
//  Multiplication
//
//  Created by Dmytro Kholodov on 10/29/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI


struct Answer: View {
    let baseColor = Color(#colorLiteral(red: 1, green: 0.8014437556, blue: 0.004643389955, alpha: 1))
    let conturColor = Color(#colorLiteral(red: 0.5953839421, green: 0.4739199877, blue: 0, alpha: 1))


    @State var scale: CGFloat = 1.0

    var body: some View {

        ZStack {

                Circle().foregroundColor(self.conturColor)
                Circle().foregroundColor(self.baseColor).padding(5)

                Button("42") {

                }
                .font(.system(size: 60))
                .foregroundColor(self.conturColor)

        }

        .frame(width: 150, height: 150)
            .scaleEffect(self.scale)
                            .animation(
                                Animation.spring()
                                    .repeatForever(autoreverses: true)
                            )


        .onAppear() {
            withAnimation(Animation.default.speed(0.3)) {
                self.scale += 0.02
            }
        }
    }
}

struct Question: View {
    let baseColor = Color(#colorLiteral(red: 1, green: 0.8014437556, blue: 0.004643389955, alpha: 1))
    let conturColor = Color(#colorLiteral(red: 0.5953839421, green: 0.4739199877, blue: 0, alpha: 1))

    @State var rotation = 0.0
    @State var scale: CGFloat = 1.0
    var body: some View {
        GeometryReader { gm in
            ZStack {
                ZStack {
                    Circle()
                        .foregroundColor(self.conturColor)

                    Circle()
                        .foregroundColor(self.baseColor)
                        .padding(5)
                }
             //   .scaleEffect(self.scale)
//                .animation(
//                    Animation.spring()
//                        .repeatForever(autoreverses: true)
//                )

                Circle()
                    .foregroundColor(.white)
                    .padding(gm.size.height * 0.1)
                    .offset(x: 0, y: gm.size.height * 0.05)

                Image("giraffe")
                    .offset(x: 0, y: -gm.size.height / 2)
                    .rotationEffect(Angle(degrees: self.rotation))
//                    .animation(
//                        Animation.default
//                            .repeatForever(autoreverses: true)
//                    )



                Text("12 x 8")
                    .font(.system(size: 70))
                    .fontWeight(.bold)
                    .foregroundColor(self.conturColor)
                    .offset(x: 0, y: gm.size.height * 0.07)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 300)
        .onAppear() {
            withAnimation(Animation.default.repeatForever(autoreverses: true)) {
                self.rotation = 5
            }
//            self.scale = 1.02
        }

    }
}


