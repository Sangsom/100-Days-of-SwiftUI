//
//  ContentView.swift
//  MeetupMem
//
//  Created by Rinalds Domanovs on 06/04/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var name = ""
    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
        VStack {
            Button(action: {
                print("Uploading image")
            }) {
                Image("upload")
            }
            .shadow(radius: 5)

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.asciiCapable)
                .padding()

            Button(action: {
                print("Saving")
            }) {    
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color(UIColor.systemBlue))
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding()
            }
            .shadow(radius: 5)
        }
        .padding(.bottom, keyboardHeight)
        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
        .animation(.easeOut(duration: 0.4))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
