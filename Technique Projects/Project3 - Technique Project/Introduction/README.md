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

## Views as properties

We can create our views as struct properties and use them in our UI. Also we can later apply modifiers for each property directly.

```swift
struct ContentView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")

    var body: some View {
        VStack {
            motto1
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)
        }
    }
}
```

## View composition

SwiftUI allows us to break complex views down into smaller ones (components).

```swift
struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
        }
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
        .font(.largeTitle)
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .clipShape(Capsule())
    }
}
```

Also we can later apply individual modifiers for our custom views.
In this case if we remove `foregroundColor` from `CapsuleText`, then we can use individual modifiers.

```swift
VStack(spacing: 10) {
    CapsuleText(text: "First")
        .foregroundColor(.white)
    CapsuleText(text: "Second")
        .foregroundColor(.yellow)
}
```

## Custom modifiers

By default `SwiftUI` provides many built-in modifiers such as `font()`, `clipShape()`, etc. But it's possible to create custom modifiers to do something specific.

We create a custom modifier called `Title()`, set up all the modifiers.

```swift
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
```

Afterwards we call it through `.modifier` modifier.

```swift
Text("Hello World")
    .modifier(Title())
```

When working with custom modifiers it's often convenient to create `extensions` on `View` that allows easier to use them.

```swift
extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}
```

Use it:

```swift
Text("Hello World")
    .titleStyle(
```

Custom modifiers can also create entirely new structures.
For example as this `Watermark`.

```swift
struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}
```

Use it:

```swift
Color.blue
    .frame(width: 300, height: 200)
    .watermarked(with: "Hacking with Swift")
```
