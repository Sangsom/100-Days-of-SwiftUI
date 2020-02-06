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
    var game = Game()

    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(game.hands, id: \.self) {
                    Image($0)
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: 100)
                        .padding()
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
