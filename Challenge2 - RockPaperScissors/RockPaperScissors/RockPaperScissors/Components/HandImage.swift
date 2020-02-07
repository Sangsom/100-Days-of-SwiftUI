//
//  HandImage.swift
//  RockPaperScissors
//
//  Created by Rinalds Domanovs on 07/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct HandImage: View {
    var name: String

    var body: some View {
        Image(name)
        .renderingMode(.original)
        .resizable()
        .frame(maxWidth: 100, maxHeight: 100)
        .padding()
    }
}
