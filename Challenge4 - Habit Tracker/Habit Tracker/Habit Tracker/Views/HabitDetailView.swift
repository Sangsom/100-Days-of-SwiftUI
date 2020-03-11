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
        VStack {
            VStack {
                Text(habit.activity)
                    .frame(maxWidth: .infinity)
                    .font(.title)
                    .padding()
                Text(habit.description)
                    .font(.body)
                    .padding([.bottom, .horizontal])
            }
            .frame(maxWidth: .infinity)
            .background(
                Color(UIColor.systemGreen)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            )
            .padding()

            Button(action: {
                
            }) {
                Text("Complete")
                    .font(.system(size: 24))
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(
                        Color(UIColor.systemGreen)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    )
                    .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var habit = Habit(activity: "Running", description: "I love to run a lot I love to run a lot I love to run a lot I love to run a lot I love to run a lot I love to run a lot ")

    static var previews: some View {
        HabitDetailView(habit: habit)
    }
}
