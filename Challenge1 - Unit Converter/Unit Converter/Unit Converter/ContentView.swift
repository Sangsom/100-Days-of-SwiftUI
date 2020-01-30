//
//  ContentView.swift
//  Unit Converter
//
//  Created by Rinalds Domanovs on 30/01/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Hello")
                }
            }
        .navigationBarTitle(Text("Unit Converter"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
