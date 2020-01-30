//
//  ContentView.swift
//  Unit Converter
//
//  Created by Rinalds Domanovs on 30/01/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var input = ""
    @State private var selectedFromUnit = 0
    @State private var selectedToUnit = 1

    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]

    var convertedResult: Double {
        let unit = Double(input) ?? 0
        var result: Double = 0

        switch (selectedFromUnit, selectedToUnit) {
        case (0, 1):
            result = (unit * 9 / 5) + 32
        case (0, 2):
            result = unit + 273
        case (1, 0):
            result = 5 / 9 * (unit - 32)
        case (1, 2):
            result = 5 / 9 * (unit - 32) + 273
        case (2, 0):
            result = unit - 273
        case (2, 1):
            result = 9 / 5 * (unit - 273) + 32
        default:
            result = unit
        }

        return result
    }


    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(temperatureUnits[selectedFromUnit])) {
                    TextField("0.0", text: $input)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("From")) {
                    Picker("Select units", selection: $selectedFromUnit) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("To")) {
                    Picker("Select units", selection: $selectedToUnit) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text(temperatureUnits[selectedToUnit])) {
                    Text("\(convertedResult, specifier: "%.2f")")
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
