//
//  Game.swift
//  PC2_RockPaperScissors
//
//  Created by Dmytro Kholodov on 10/18/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//
import Foundation
import Combine

enum Goal: CaseIterable {

    case win
    case lose
    var description: String {
        switch self {
        case .win:
            return "WIN"
        case .lose:
            return "LOSE"
        }
    }
}

enum Item: CaseIterable, Hashable, CustomStringConvertible {

//    case rock
//    case paper
//    case scissors
    case dog
    case cat
    case mouse
    case elephant

    var description: String {
        switch self {
//        case .rock:
//            return "💎"
//        case .paper:
//            return "📃"
//        case .scissors:
//            return "✂️"
        case .dog:
            return "🐶"
        case .cat:
            return "🐱"
        case .mouse:
            return "🐭"
        case .elephant:
            return "🐘"
        }
    }
}

extension Item {
    static var random: Item {
        Item.allCases.randomElement() ?? .mouse
    }
}

class Game: ObservableObject {
    @Published var showCorrectFlag = false

    @Published var score = -1
    @Published var total = 10
    @Published var answers: [Bool] = []

    @Published var gameOver = true


    /// In secods, less is harder
    var timePressure: TimeInterval = 3

    var wasPlayed: Bool {
        self.score >= 0
    }


    @Published var currentGoal = Goal.win
    @Published var currentMove = Item.mouse

    var possibleMoves: [Item] {
        Item.allCases.shuffled()
    }

    var rules: [Item: Set<Item>] = [
//        .scissors: [.paper],
//        .paper: [.rock],
//        .rock: [.scissors],
        .elephant: [.dog],
        .dog: [.cat],
        .cat: [.mouse],
        .mouse: [.elephant],
    ]

    var timer: Timer? = nil

    public func reset() {
        gameOver = false
        answers = []
        score = 0
        askQuestion()
    }


    // MARK: - Private

    private func isMoveCorrect(with item: Item?) -> Bool {
        guard let item = item else { return false }
        let chosenBeatsCurrent = rules[item]?.contains(currentMove) ?? false
        switch currentGoal {
        case .win:
            return chosenBeatsCurrent
        case .lose:
            return chosenBeatsCurrent == false
        }
    }


    private func askQuestion() {
        currentGoal = Goal.allCases.randomElement()!
        currentMove = Item.random

        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: self.timePressure, repeats: false) { [weak self] _ in
            if let self = self {
                self.move(with: nil)
            }
        }
    }

    public func move(with item: Item?) {
        let result = isMoveCorrect(with: item)
        if result { score += 1 }
        answers.append(result)

        self.askQuestion()

        if self.answers.count >= self.total {
            self.gameOver = true
        }
    }
}
