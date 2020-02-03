//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rinalds Domanovs on 01/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        VStack {
            Text("Tap the flag off")
            Text(countries[correctAnswer])

            ForEach(0 ..< 3) { number in
                Button(action: {
                    // flag was tapped
                }) {
                    Image(self.countries[number])
                        .renderingMode(.original)
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
