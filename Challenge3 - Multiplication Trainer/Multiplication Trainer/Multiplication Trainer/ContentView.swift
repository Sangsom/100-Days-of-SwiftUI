//
//  ContentView.swift
//  Multiplication Trainer
//
//  Created by Rinalds Domanovs on 18/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct Question: Identifiable {
    var id = UUID()
    var multiplier: Int
    var multiplicand: Int
    var result: Int {
        get {
            return multiplier * multiplicand
        }
    }
}

struct ContentView: View {
    @State private var gameStarted = false
    @State private var multiplicationTables: Int = 4
    @State private var questionAmount = 10
    @State private var questions: [Question] = []
    @State private var currentQuestion = 0
    @State private var userAnswer = ""

    var questionsAmount = [5, 10, 20, 0]

    var body: some View {
        return NavigationView {
            if gameStarted {
                // Game Started
                VStack {
                    Spacer()
                    HStack {
                        Text("What is \(questions[currentQuestion].multiplier) x \(questions[currentQuestion].multiplicand) = ")
                        TextField("", text: $userAnswer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    .padding(.horizontal)

                    Button("Check") {
                        print("Tapped")
                    }

                    Spacer()
                    Spacer()
                }
                .font(.title)
                .navigationBarTitle(Text("Game Started"))
                .navigationBarItems(leading: Button(action: {
                    self.gameStarted.toggle()
                }) {
                    Text("Back")
                })
            } else {
                // Game Settings
                Form {
                    Section(header: Text("Select multiplication table difficulty")) {
                        Stepper("\(multiplicationTables) table", value: $multiplicationTables, in: 1...12)
                    }

                    Section(header: Text("How many questions?")) {
                        Picker("", selection: $questionAmount) {
                            ForEach(questionsAmount, id: \.self) {
                                Text("\($0 == 0 ? "All" : "\($0)")")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    Section {
                        Button(action: {
                            self.gameStarted.toggle()
                            // Generate game
                            var tempQuestions: [Question] = []

                            for i in 1...self.multiplicationTables {
                                for j in 1...10 {
                                    tempQuestions.append(Question(multiplier: i, multiplicand: j))
                                }
                            }

                            tempQuestions.shuffle()
                            if self.questionAmount == 0 {
                                self.questions = tempQuestions
                            } else {
                                self.questions = Array(tempQuestions.prefix(self.questionAmount))
                            }
                        }) {
                            HStack {
                                Text("Start".uppercased())
                                    .font(.title)
                                    .foregroundColor(Color(.systemOrange))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .cornerRadius(40)
                        }
                    }
                }
                .navigationBarTitle(Text("Settings"))
                .navigationBarItems(leading: EmptyView())
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
