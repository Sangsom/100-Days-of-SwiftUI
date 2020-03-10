//
//  HabitDetailView.swift
//  Habit Tracker
//
//  Created by Rinalds Domanovs on 10/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct HabitDetailView: View {
    var habit: Habit!

    var body: some View {
        Text(habit.activity)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView()
    }
}
