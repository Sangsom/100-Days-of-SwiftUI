//
//  ContentView.swift
//  Unit Converter
//
//  Created by Rinalds Domanovs on 30/01/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var fromUnit = ""
    @State private var toUnit = ""
    @State private var result = ""

    @State private var selectedFromUnit = 0
    @State private var selectedToUnit = 1

    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Units to convert from")) {
                    TextField("From", text: $fromUnit)
                        .keyboardType(.decimalPad)

                    Picker("Select units", selection: $selectedFromUnit) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0])")
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Units to convert to")) {
                    TextField("To", text: $toUnit)
                        .keyboardType(.decimalPad)

                    Picker("Select units", selection: $selectedToUnit) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0])")
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
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
