//
//  HabitsController.swift
//  Habit Tracker
//
//  Created by Rinalds Domanovs on 09/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import Foundation

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
