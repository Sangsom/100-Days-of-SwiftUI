//
//  AddHabitView.swift
//  Habit Tracker
//
//  Created by Rinalds Domanovs on 09/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct AddHabitView: View {
    @State private var activity: String = ""
    @State private var description: String = ""

    var body: some View {
        Form {
            TextField("Activity", text: $activity)

            TextField("Description", text: $description)
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView()
    }
}
