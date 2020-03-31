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
