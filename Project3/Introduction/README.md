# Introduction

In current technique project we will see how to build `custom view modifiers`, `custom containers`, and more.

## Views and modifiers

Reasons of why in `SwiftUI` are used structs instead of classes.

- Structs are simpler and faster than classes.
- In SwiftUI all views are just structs, holding only those attributes, properties that you defined, they don't inherit everything like in UIKit.
- By creating views with structs, it forces us to think about isolating state in a clean way.

## Modifiers

When we add a modifier for our `SwiftUI` views, we actually create a new view every time the new change is applied.

## Conditional modifiers

We can use modifiers conditionally with `ternary operator`.

```swift
struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            self.useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}
```

## Environment modifiers

Many modifier can be applied to containers, in this case if we apply `.font()` modifier to `VStack`, font will be applied to all the text views inside container. It's called environment modifier.

```swift
VStack {
    Text("Gryffindor")
    Text("Hufflepuff")
    Text("Ravenclaw")
    Text("Slytherin")
}
.font(.title)
```

If child view have applied modifier then the priority will take child view and outer modifier will be applied to other views.

```swift
VStack {
    Text("Gryffindor")
        .font(.largeTitle)
    Text("Hufflepuff")
    Text("Ravenclaw")
    Text("Slytherin")
}
.font(.title)
```
