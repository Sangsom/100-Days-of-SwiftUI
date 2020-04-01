//
//  ContentView.swift
//  Instafilter
//
//  Created by Rinalds Domanovs on 31/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.secondary)

                // display the image
            }
            .onTapGesture {
                // select an image
            }

            HStack {
                Text("Intensity")
                Slider(value: $filterIntensity)
            }.padding(.vertical)

            HStack {
                Button("Change Filter") {
                    // change filter
                }

                Spacer()

                Button("Save") {
                    // save the picture
                }
            }
        }
        .padding([.horizontal, .bottom])
        .navigationBarTitle("Instafilter")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
