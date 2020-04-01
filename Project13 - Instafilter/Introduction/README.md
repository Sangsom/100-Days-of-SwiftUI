# Introduction

## Creating custom bindings in SwiftUI

Because of the way SwiftUI sends binding updates to property wrappers, assigning property observers used with property wrappers won’t work, which means this kind of code won’t print anything even as the blur radius changes:

```swift
struct ContentView: View {
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)
        }
    }
}
```

To fix this we need to create a custom binding – we need to use the `Binding` struct directly, which allows us to provide our own code to run when the value is read or written.

```swift
struct ContentView: View {
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )

        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: blur, in: 0...20)
        }
    }
}
```

## Actionsheet

```swift
struct ContentView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white

    var body: some View {
        Text("Hello, World")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                .default(Text("Red")) { self.backgroundColor = .red },
                .default(Text("Green")) { self.backgroundColor = .green },
                .default(Text("Blue")) { self.backgroundColor = .blue },
                .cancel()
            ])
        }
    }
}
```

![ActionSheet](https://media.giphy.com/media/jtioNVo18A3uOakPFG/giphy.gif)

## Integrating Core Image with SwiftUI

```swift
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        guard let inputImage = UIImage(named: "example") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()

//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1

//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 100

        let currentFilter = CIFilter.crystallize()
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.radius = 200

        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }

        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)

            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}
```

![Imgur](https://i.imgur.com/ZsN9VHzm.png)

## Wrapping a UIViewController in a SwiftUI view

Create a new file for `ImagePicker``

```swift
struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
          return
      }
}
```

And use in `SwiftUI`

```swift
struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
}
```

![ImagePicker](https://media.giphy.com/media/lPpFKfw41kVBLr9U5s/giphy.gif)

## Using coordinators to manage SwiftUI view controllers

In this sample it's `ImagePicker` file with coordinators.

```swift
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
          return
    }
}
```

And you can use it in ContentView file.

```swift
struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}
```

## Saving images to user's photo library
