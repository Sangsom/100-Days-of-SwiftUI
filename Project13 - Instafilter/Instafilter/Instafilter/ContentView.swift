//
//  ContentView.swift
//  Instafilter
//
//  Created by Rinalds Domanovs on 31/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter = CIFilter.sepiaTone()

    let context = CIContext()

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.secondary)

                // display the image
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .onTapGesture {
                self.showingImagePicker = true
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
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func applyProcessing() {
        currentFilter.intensity = Float(filterIntensity)

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
