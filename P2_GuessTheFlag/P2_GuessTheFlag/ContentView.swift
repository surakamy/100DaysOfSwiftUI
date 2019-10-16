//
//  AppDelegate.swift
//  P2_GuessTheFlag
//
//  Created by Dmytro Kholodov on 10/13/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

// MARK: - Style

struct PressedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}



struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
            .shadow(color: .white, radius: 2)
            .buttonStyle(PressedButtonStyle())

    }
}

struct FlagButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 1))
            .shadow(color: .white, radius: 2)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

// MARK: - Views

struct QuestionView: View {
    var countryName: String
    var body: some View {
        VStack(spacing: 10) {
            Text(countryName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                .shadow(color: .white, radius: 2)
                .offset(CGSize(width: 0, height: -20))
        }
    }
}

struct FlagView: View {
    var country: String
    var action:  () -> Void
    var body: some View {
        Button(action: action) {
            Image(country)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
        }
        .buttonStyle(FlagButtonStyle())
    }
}

struct ScoreView: View {
    var current: Int
    var total: Int
    var answers: [Bool]

    var body: some View {
        VStack {
            Text("Guess the Flag")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.largeTitle)

            HStack {
                ForEach(0..<total) { number in
                    if self.answers.count > number {
                        Circle()
                            .frame(maxHeight: 30)
                            .foregroundColor(self.answers[number] ? Color.green : Color.red)
                            .overlay(Circle()
                            .stroke(Color.white, lineWidth: 1))
                    } else {
                        Circle()
                            .frame(maxHeight: 30)
                    }
                }
            }.padding()
        }
    }
}

struct GameView: View {
    @ObservedObject var game: Game

    var body: some View {
        VStack {
           QuestionView(countryName: game.correctCountry)

          //  Spacer()
            BoardView(rows: 4, columns: 3) { number in

                FlagView(country: self.game[number]) {
                    self.game.flagTapped(number)
                }
                .opacity(
                    !self.game.showCorrectFlag ||
                        self.game[number] == self.game.correctCountry
                        ? 1.0
                        : 0.3
                )
                .animation(.spring())
            }
//
//            HStack(spacing: 5) {
//                VStack(spacing: 5) {
//                    ForEach((0..<3)) { number in
//                        FlagView(country: self.game[number]) {
//                            self.game.flagTapped(number)
//                        }
//                        .opacity(
//                            !self.game.showCorrectFlag ||
//                                self.game[number] == self.game.correctCountry
//                                ? 1.0
//                                : 0.3
//                        )
//                        .animation(.spring())
//                    }
//                }
//                VStack(spacing: 5) {
//                    ForEach((3..<6)) { number in
//                        FlagView(country: self.game[number]) {
//                            self.game.flagTapped(number)
//                        }
//                        .opacity(
//                            !self.game.showCorrectFlag ||
//                                self.game[number] == self.game.correctCountry
//                                ? 1.0
//                                : 0.3
//                        )
//                            .animation(.spring())
//                    }
//                }
//            }.padding()
        }
    }
}

struct MenuView: View {
    @ObservedObject var game: Game

    var body: some View {
        VStack {
            Text("\(game.score)")
                .font(.system(size: 100))
            Text("----------------------")
            Text("\(game.total)")
                .font(.system(size: 100))

            Spacer()

            Button(action: game.reset) {
                Text("Play again")
                    .padding()
                    .padding(.leading, 50)
                    .padding(.trailing, 50)
                    .font(.largeTitle)
            }
                // .frame(width: .infinity) Causes a crash!!!
            .buttonStyle(MenuButtonStyle())
        }
    }
}

// MARK: - Game Logic

class Game: ObservableObject {
    @Published var showCorrectFlag = false

    @Published var score = 0
    @Published var total = 10
    @Published var answers: [Bool] = []

    @Published var gameOver = false

    var countInColumn = 3

    public var correctCountry: String {
        countries[correctAnswer]
    }

    public subscript(index: Int) -> String {
        assert(countries.indices.contains(index), "Index is out of bounds, you know!")
        return self.countries[index]
    }

    public func flagTapped(_ number: Int) {
        let result = number == correctAnswer
        answers.append(result)

        if result { score += 1 }

        showCorrectFlag = true
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.showCorrectFlag = false
            self.askQuestion()
            if self.answers.count >= self.total {
                self.gameOver = true
            }
        }
    }

    public func reset() {
        gameOver = false
        answers = []
        score = 0
        askQuestion()
    }


    // MARK: - Private
    private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US", "Ukraine"].shuffled()
    private var correctAnswer = Int.random(in: 0...5)

    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...5)
    }
}





struct ContentView: View {

    @ObservedObject var game = Game()

    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [Color.orange, .red, .orange, .red, .orange]), center: .bottom)
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                ScoreView(current: game.score, total: game.total, answers: game.answers)

                Spacer()

                if game.gameOver {
                    MenuView(game: game)
                } else {
                    GameView(game: game)
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
