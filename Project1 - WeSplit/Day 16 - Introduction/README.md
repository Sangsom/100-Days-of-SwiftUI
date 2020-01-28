# Project 1, part one

In current we will review `Form`, `NavigationView`, `@State`, and more...

This is initially generated sample code.

```swift
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
```

`struct ContentView: View` creates a new struct that conforms to a `View` protocol.

`View` comes from `SwiftUI` and is the basic protocol that should be adopted by anything we want to create on screen (Buttons, Text, images, views etc).

`var body: some View` means that it must return something that conforms to a `View` protocol, and `some` keyword says that it always must be returned the same kind of view.
