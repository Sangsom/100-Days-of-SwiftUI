//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Rinalds Domanovs on 07/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct Habit: Identifiable {
    var id = UUID()
    var activity: String
    var description: String
}

class HabitsController: ObservableObject {
    @Published var habits: [Habit]

    init() {
        let items = [Habit(activity: "Running", description: "Just 3km"), Habit(activity: "Read a tutorial", description: "Something about SwiftUI")]
        self.habits = items
    }
}

struct ContentView: View {
    var habitsController = HabitsController()

    var body: some View {
        NavigationView {
            VStack {
                ForEach(habitsController.habits) {
                    Text("\($0.activity)")
                }
            }
            .navigationBarTitle("Habit Tracker")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var habits = HabitsController()

    static var previews: some View {
        ContentView()
    }
}
