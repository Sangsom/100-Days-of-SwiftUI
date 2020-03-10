//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Rinalds Domanovs on 07/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddNewHabit = false

    var habitsController = HabitsController()

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack(spacing: 5) {
                    ForEach(habitsController.habits) { habit in
                        NavigationLink(destination: HabitDetailView(habit: habit)) {
                            Text("\(habit.activity)")
                                .frame(maxWidth: .infinity)
                                .background(
                                    Color(UIColor.systemGreen)
                                    .frame(height: 44)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
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
