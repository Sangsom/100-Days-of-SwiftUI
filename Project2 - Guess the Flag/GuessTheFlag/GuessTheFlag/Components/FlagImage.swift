//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Rinalds Domanovs on 05/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//
import SwiftUI

struct FlagImage: View {
    var name: String

    var body: some View {
        Image(name)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 2)
    }
}
