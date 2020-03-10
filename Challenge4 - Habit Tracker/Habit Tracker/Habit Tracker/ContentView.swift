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
            VStack {
                ForEach(habitsController.habits) {
                    Text("\($0.activity)")
                }
            }
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
        ContentView()
    }
}
