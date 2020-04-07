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
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    @State private var name = ""
    @State private var keyboardHeight: CGFloat = 0

    var isValid: Bool {
        if name.count > 3 && image != nil {
            return true
        } else {
            return false
        }
    }

    var body: some View {
        VStack {


            Button(action: {
                self.showingImagePicker = true
            }) {
                if image != nil {
                    image?
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())

                } else {
                    Image("upload")
                }
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
                    .background(isValid ? Color(UIColor.systemBlue) : Color(UIColor.systemGray))
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding()
            }
            .shadow(radius: 5)
            .disabled(!isValid)
        }
        .padding(.bottom, keyboardHeight)
        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
        .animation(.easeOut(duration: 0.4))
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
