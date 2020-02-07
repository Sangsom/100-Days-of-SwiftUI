//
//  HeaderView.swift
//  RockPaperScissors
//
//  Created by Rinalds Domanovs on 07/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var score: Int
    var round: Int

    var body: some View {
        HStack {
            Text("Score: \(score)")
                .font(.headline)
                .foregroundColor(Color(.systemGray))
            Spacer()
            Text("Round: \(round)")
                .font(.headline)
                .foregroundColor(Color(.systemGray))
        }
        .padding()
    }
}
