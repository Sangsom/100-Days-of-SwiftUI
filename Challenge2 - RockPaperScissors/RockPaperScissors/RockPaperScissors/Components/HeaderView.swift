//
//  HeaderView.swift
//  RockPaperScissors
//
//  Created by Rinalds Domanovs on 07/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct DiagramView: View {
    var body: some View {
        Image("diagram")
            .renderingMode(.original)
            .resizable()
            .frame(maxWidth: 100, maxHeight: 100)
    }
}

struct HeaderView: View {
    var score: Int
    var round: Int

    var body: some View {
        VStack {
            HStack {
                Text("Score: \(score)")
                    .font(.headline)
                    .foregroundColor(Color(.systemGray))
                Spacer()
                Text("Round: \(round)")
                    .font(.headline)
                    .foregroundColor(Color(.systemGray))
                    .padding()
            }
            .padding()

            DiagramView()
        }

    }
}
