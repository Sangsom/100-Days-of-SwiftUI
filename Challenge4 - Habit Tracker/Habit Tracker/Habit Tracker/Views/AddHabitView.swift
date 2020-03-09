//
//  AddHabitView.swift
//  Habit Tracker
//
//  Created by Rinalds Domanovs on 09/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var activity: String = ""
    @State private var description: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Activity", text: $activity)

                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add activity", displayMode: .inline)
            .navigationBarItems(leading: Button("Back") {
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Text("Add"))
        }
        .onAppear(perform: {
            print(self.presentationMode)
        })
        .onDisappear {
            print(self.presentationMode)
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView()
    }
}
