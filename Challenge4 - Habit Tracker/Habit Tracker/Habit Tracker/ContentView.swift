//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Rinalds Domanovs on 07/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var showingAddNewHabit = false

    var habitsController = HabitsController()

    var shadowColor: Color {
        if colorScheme == .dark {
            return Color(UIColor.white)
        } else {
            return Color(UIColor.black)
        }
    }

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack(spacing: 5) {
                    ForEach(habitsController.habits) { habit in
                        NavigationLink(destination: Text("Hello")) {
                            Text("\(habit.activity)")
                                .frame(maxWidth: .infinity)
                                .background(
                                    Color(UIColor.systemGreen)
                                    .frame(height: 44)
                                    .cornerRadius(10)
                                    .shadow(color: self.shadowColor, radius: 3, x: 0, y: 0)
                                )
                                .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            })
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddNewHabit.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(Color(UIColor.systemOrange))
                    .font(.title)
                    .padding()
            })
        }
        .sheet(isPresented: $showingAddNewHabit) {
            AddHabitView(habitsController: self.habitsController)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var habits = HabitsController()

    static var previews: some View {
//        habits.habits.append(Habit(activity: "Running", description: "I love to run a lot"))
//        habits.habits.append(Habit(activity: "Read a tutorial", description: "Something about SwiftUI"))
        return ContentView()
    }
}
