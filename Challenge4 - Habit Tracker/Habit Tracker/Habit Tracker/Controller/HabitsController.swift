//
//  HabitsController.swift
//  Habit Tracker
//
//  Created by Rinalds Domanovs on 09/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import Foundation

struct Habit: Identifiable, Codable {
    let id = UUID()
    let activity: String
    let description: String
    var timesCompleted: Int = 0
}

class HabitsController: ObservableObject {
    init() {
        if let habits = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: habits) {
                self.habits = decoded
                return
            }
        }

        self.habits = []
    }

    @Published var habits: [Habit] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
}
