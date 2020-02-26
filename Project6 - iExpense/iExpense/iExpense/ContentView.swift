//
//  ContentView.swift
//  iExpense
//
//  Created by Rinalds Domanovs on 25/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()

    @State private var showingAddExpenses = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    self.expenses.items.append(expense)
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddExpenses) {
            AddView()
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
