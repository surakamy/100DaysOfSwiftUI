//
//  ContentView.swift
//  P5_Word_Scramble
//
//  Created by Dmytro Kholodov on 10/22/19.
//  Copyright © 2019 TheHackingWithSwift. All rights reserved.
//

import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

extension Character: Identifiable {
    public var id: Character { self }
}


struct WordView: View {
    var word: String

    var spelled: [Character] {
        Array(word)
    }

    var fontSize: CGFloat {
        CGFloat.random(in: 20...34)
    }

    var backgroundColor: Color {
        Color(red: Double.random(in: 0.4...1), green: Double.random(in: 0.4...1), blue: Double.random(in: 0.4...1))
    }

    var body: some View {
        HStack(alignment: .center) {
            ForEach(spelled) { c in
                Text(String(c))
                    .font(.system(size: self.fontSize))
                    .fontWeight(.black)
                    .padding(4)
                    .border(Color.black, width: 0.5)
                    .background(self.backgroundColor)
                    .rotationEffect(Angle(degrees: Double.random(in: -10...10)))
            }
        }

        .padding()

        .drawingGroup()
    }
}

struct ContentView: View {
    //@State var allWords: [String] = ContentView.loadWords()

    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    var score: Int {
        usedWords.reduce(0, { $0 + $1.count - 2 })
    }

    var body: some View {
        NavigationView {
            List() {
                Section(header: Text("A new word?")) {
                    TextField("Enter here", text: $newWord, onCommit: addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                }

                Section(header: Text("Score is \(score)")) {
                    ForEach(usedWords) { w in
                        HStack {
                            Image(systemName: "\(w.count).circle")
                            WordView(word: w)
                            Spacer()
                        }
                    }
                }


            }



            .navigationBarTitle(rootWord)

            .navigationBarItems(trailing: Button("Restart") {
                self.startGame()
            })
        }


        .onAppear(perform: startGame)



        .alert(isPresented: $showingError) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }


    private static func loadWords() -> [String] {
        let resUrl = Bundle.main.url(forResource: "start", withExtension: "txt")
        let rawString = try! String(contentsOf: resUrl!)
        return rawString.split(separator: "\n").map(String.init)
    }

    private func startGame() {
        let allWords: [String] = ContentView.loadWords()
        rootWord = allWords.randomElement() ?? "silkworm"
        usedWords = [String]()
        newWord = ""
    }

    private func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }

        usedWords.insert(answer, at: 0)
        newWord = ""
    }

    func isReal(word: String) -> Bool {

        guard word.count >= 3 else {
            return false
        }

        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    private func isOriginal(word: String) -> Bool {
        guard word != rootWord else { return false }
        return !usedWords.contains(word)
    }

    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
