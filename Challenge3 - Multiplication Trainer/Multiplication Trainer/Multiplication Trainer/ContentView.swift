//
//  ContentView.swift
//  Multiplication Trainer
//
//  Created by Rinalds Domanovs on 18/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var gameStarted = false
    @State private var multiplicationTables: Int = 1

    var body: some View {

        Group {
            if gameStarted {
                // Game Started
                Text("Game Started")
            } else {
                // Game Settings
                VStack {
                    Text("Settings")
                        .font(.largeTitle)

                    Form {
                        Section(header: Text("Select table")) {
                            Stepper("\(multiplicationTables) table", value: $multiplicationTables, in: 1...12)
                        }
                    }


                    Text("Table \(multiplicationTables)")


                    Button("Start Game") {
                        self.gameStarted.toggle()
                    }
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
