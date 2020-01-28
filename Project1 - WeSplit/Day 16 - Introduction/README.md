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

## Creating a form

In SwiftUI are `Form` view that are scrolling lists of static controls like text and images.

In `Form`'s you can have as many items as you want, but you shouldn't add more than 10. If you need more then you need to use groups.

```swift
var body: some View {
    Form {
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
    }
}
```

### Groups

```swift
Form {
    Group {
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
    }

    Group {
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
    }
}
```

### Sections

If you want a visual differences splitting elements in form, then you need to use `Sections`.

```swift
Form {
    Section {
        Text("Hello World")
    }

    Section {
        Text("Hello World")
        Text("Hello World")
    }
}
```
