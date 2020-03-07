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

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Gello")
            }
            .navigationBarTitle("Habit Tracker")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
