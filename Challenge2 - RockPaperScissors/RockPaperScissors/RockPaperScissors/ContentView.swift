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

    var game = Game()

    var body: some View {
        VStack {
            Spacer()
            Text("Hello")
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
    }

    func nextRound() {
        enemyHand = Int.random(in: 0 ..< game.hands.count)
        print(enemyHand)
    }

    func handTapped(_ hand: String) {
        nextRound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
