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

## Navigation Bar

Adding navigation bar.

```swift
var body: some View {
    NavigationView {
        Form {
            Section {
                Text("Hello World")
            }
        }
    }
}
```

You can add a title to navigation bar and this can be done by attaching _modifier_ wherever you've placed inside.

`Modifiers` are a regular methods that always return a `new instance` of whatever you use them on.

```swift
var body: some View {
    NavigationView {
        Form {
            Section {
                Text("Hello World")
            }
        }
    .navigationBarTitle(Text("SwiftUI"))
    }
}
```

> Tip: When we attach `.navigationBarTitle()` modifier to our form, Swift actually creates a new form that has a navigation bar title plus all existing contents you provided.

You can set title small instead of large.

```swift
.navigationBarTitle(Text("SwiftUI"), displayMode: .inline)
```
