//
//  ContentView.swift
//  MeetupMem
//
//  Created by Rinalds Domanovs on 06/04/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            print("Uploading image")
        }) {
            Image("upload")
        }
    .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
