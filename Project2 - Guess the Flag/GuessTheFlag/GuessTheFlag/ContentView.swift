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
    @State private var flagDegrees = [0.0, 0.0, 0.0]
    @State private var opacity = 1.0
    @State private var offset = CGSize(width: 0, height: 0)

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
                .animation(.default)
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
                        withAnimation {
                            if number == self.correctAnswer {
                                self.flagDegrees[number] += 360
                            }
                        }

                        if number != self.correctAnswer {
                            withAnimation(Animation.easeOut(duration: 0.1).repeatCount(5)) {
                                self.offset = CGSize(width: 5, height: 0)
                            }
                        }
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(self.flagDegrees[number]), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.showingScore && number != self.correctAnswer ? 0.25 : 1.0)
                    .offset(self.offset)
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
        self.offset = CGSize(width: 0, height: 0)
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
