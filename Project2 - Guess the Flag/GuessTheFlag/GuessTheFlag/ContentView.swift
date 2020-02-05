//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rinalds Domanovs on 01/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    private let colors: [Color] = [
        Color(UIColor.systemBlue),
        Color(UIColor.systemGreen),
        Color(UIColor.systemIndigo),
        Color(UIColor.systemOrange),
        Color(UIColor.systemPink),
        Color(UIColor.systemPurple),
        Color(UIColor.systemRed),
        Color(UIColor.systemTeal),
        Color(UIColor.systemYellow)
    ]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: getRandomColors()), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .frame(minWidth: 0, maxWidth: .infinity)

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                }
                Text("Your score is \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct 👌"
            score += 10
        } else {
            scoreTitle = "Sorry bro, it was flag of \(countries[number]) 😤"
            score -= 5
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func getRandomColors() -> [Color] {
        let shuffled = colors.shuffled()

        return [shuffled[0], shuffled[1]]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
