//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Rinalds Domanovs on 06/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Game {
    let rocks = ["✊", "✊🏻", "✊🏼", "✊🏽", "✊🏾", "✊🏿"]
    let papers = ["✋", "✋🏻", "✋🏼", "✋🏽", "✋🏾", "✋🏿"]
    let scissors = ["✌️", "✌🏻", "✌🏼", "✌🏽", "✌🏾", "✌🏿"]
}
