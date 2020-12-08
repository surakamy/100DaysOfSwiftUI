//
//  CardView.swift
//  Flashzilla
//
//  Created by Dmytro Kholodov on 12/24/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let card: Card
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    var removal: (() -> Void)? = nil
    @State private var feedback = UINotificationFeedbackGenerator()

    @Environment(\.accessibilityDifferentiateWithoutColor)
    var differentiateWithoutColor

    @Environment(\.accessibilityEnabled)
    var accessibilityEnabled

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(
                differentiateWithoutColor
                    ? Color.white
                    : Color.white
                        .opacity(1 - Double(abs(offset.width / 50)))

            )
            .background(
                differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width > 0 ? Color.green : Color.red)
            )
            .shadow(radius: 10)
            

            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .accessibility(addTraits: .isButton)
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
            .gesture(
                DragGesture()
                    .onChanged { offset in
                        self.offset = offset.translation
                        self.feedback.prepare()
                    }

                    .onEnded { _ in
                        if abs(self.offset.width) > 100 {
                            if self.offset.width > 0 {
                                self.feedback.notificationOccurred(.success)
                            } else {
                                self.feedback.notificationOccurred(.error)
                            }

                            self.removal?()
                        } else {
                            self.offset = .zero
                        }
                    }
            )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
}
