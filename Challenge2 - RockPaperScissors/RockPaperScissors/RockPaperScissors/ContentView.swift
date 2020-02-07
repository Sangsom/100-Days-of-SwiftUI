//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Rinalds Domanovs on 06/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct Game {
    let hands = ["rock", "paper", "scissors"]
}

struct ContentView: View {
    @State private var enemyHand = 0
    @State private var shouldPlayerWin = false
    @State private var score = 0
    @State private var currentRound = 1
    @State private var showAlert = false

    var game = Game()
    let totalRounds = 3

    var winOrLose: String {
        return shouldPlayerWin ? "Win" : "Lose"
    }

    var body: some View {
        VStack {
            HeaderView(score: score, round: currentRound)
            Spacer()
            Text("You must")
                .font(.headline)
                .foregroundColor(Color(.systemGray))
            Text(winOrLose)
                .font(.largeTitle)
                .foregroundColor(shouldPlayerWin ? Color(.systemGreen) : Color(.systemRed))
            Image(game.hands[enemyHand])
            Spacer()
            HStack {
                ForEach(game.hands, id: \.self) { hand in
                    Button(action: {
                        self.handTapped(hand)
                    }) {
                        HandImage(name: hand)
                    }
                }
            }
        }
        .onAppear {
            self.startGame()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Game Over"), message: Text("You scored \(score) points"), dismissButton: .default(Text("Restart")) {
                self.startGame()
            })
        }
    }

    func startGame() {
        currentRound = 1
        shouldPlayerWin = Bool.random()
        enemyHand = Int.random(in: 0 ..< game.hands.count)
    }

    func nextRound() {
        shouldPlayerWin = Bool.random()
        enemyHand = Int.random(in: 0 ..< game.hands.count)
    }

    func handTapped(_ hand: String) {
        if currentRound < totalRounds {
            currentRound += 1
            compareHands(player: hand, pc: game.hands[enemyHand])
            nextRound()
        } else {
            compareHands(player: hand, pc: game.hands[enemyHand])
            showAlert = true
        }
    }

    func compareHands(player: String, pc: String) {
        if shouldPlayerWin {
            if player == "rock" && pc == "paper" {
                roundLose()
            } else if player == "rock" && pc == "scissors" {
                roundWon()
            } else if player == "paper" && pc == "rock" {
                roundWon()
            } else if player == "paper" && pc == "scissors" {
                roundLose()
            } else if player == "scissors" && pc == "rock" {
                roundLose()
            } else if player == "scissors" && pc == "paper" {
                roundWon()
            } else {
                draw()
            }
        } else {
            if player == "rock" && pc == "paper" {
                roundWon()
            } else if player == "rock" && pc == "scissors" {
                roundLose()
            } else if player == "paper" && pc == "rock" {
                roundLose()
            } else if player == "paper" && pc == "scissors" {
                roundWon()
            } else if player == "scissors" && pc == "rock" {
                roundWon()
            } else if player == "scissors" && pc == "paper" {
                roundLose()
            } else {
                draw()
            }
        }
    }

    func roundWon() {
        score += 1
    }

    func roundLose() {
        score -= 1
    }

    func draw() {
        print("DRAW")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
