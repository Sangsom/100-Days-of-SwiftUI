//
//  AmountText.swift
//  iExpense
//
//  Created by Rinalds Domanovs on 27/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct AmountText: View {
    var amount: Int
    var color: Color {
        if amount < 10 {
            return Color.gray
        } else if amount < 100 {
            return Color.orange
        } else {
            return Color.red
        }
    }

    var body: some View {
        Text("$\(amount)")
            .font(.title)
            .foregroundColor(color)
    }
}

struct AmountText_Previews: PreviewProvider {
    static var previews: some View {
        AmountText(amount: 15)
    }
}
