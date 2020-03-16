# Introduction

Here we will learn about `@Binding`, `type erasure`, `Core Data`, and more.

## Custom component with `@Binding`

`@Binding` lets us connect an `@State` property of one view to some underlying model data.

```swift
struct ContentView: View {
    @State private var rememberMe = false

    var body: some View {
        Toggle(isOn: $rememberMe) {
            PushButton(title: "Remember Me", isOn: $rememberMe.animation())
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}
```

![Binding usage](https://media.giphy.com/media/IbkflevgKCUeiupyGE/giphy.gif)

## Using size classes with AnyView type erasure

Size classes are Apple's way of telling us how much space we have for our views.

It allows to return different view depending on sizeClass.

```swift
struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}
```
