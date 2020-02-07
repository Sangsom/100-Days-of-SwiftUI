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

struct HeaderView: View {
    var score: Int

    var body: some View {
        HStack {
            Spacer()
            Text("Score: \(score)")
                .font(.headline)
                .foregroundColor(Color(.systemGray))
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var enemyHand = 0
    @State private var shouldPlayerWin = false
    @State private var score = 0

    var game = Game()

    var winOrLose: String {
        return shouldPlayerWin ? "Win" : "Lose"
    }

    var body: some View {
        VStack {
            HeaderView(score: score)
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
                        Image(hand)
                            .renderingMode(.original)
                            .resizable()
                            .frame(maxWidth: 100, maxHeight: 100)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            self.nextRound()
        }
    }

    func nextRound() {
        shouldPlayerWin = Bool.random()
        enemyHand = Int.random(in: 0 ..< game.hands.count)
    }

    func handTapped(_ hand: String) {
        nextRound()

        print("Player \(hand): PC \(game.hands[enemyHand]): WinOrLose - \(shouldPlayerWin)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
