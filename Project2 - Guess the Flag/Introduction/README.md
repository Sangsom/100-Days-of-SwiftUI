# Introduction

In current project we will see `VStack`, `Image`, `Alert`, and more.

## Stacks for arranging views

When we want to add multiple items in a view we should `HStack`, `VStack`, or `ZStack`.

This adds two `Text` views vertically with a spacing of 20 between them.

```swift
VStack(alignment: .leading, spacing: 20) {
    Text("Hello World")
    Text("This is inside a stack")
}
```

By default stacks are adding views in center. But if we want to push views then we can add `Spacer()` and it will push your content to one side, and take automatically all remaining space.

```swift
VStack(alignment: .leading, spacing: 20) {
    Text("First")
    Text("Second")
    Text("Third")
    Spacer()
}
```

`ZStack` add views one on other. They are arranged by depth.

```swift
ZStack {
    Text("Hello World")
    Text("This is inside a stack")
}
```

## Colors and frames

If we want to create a full background views color than we should put color as a `View` inside.

`Color.red` is a view by itself, which is why it can be used like shapes and text. It automatically takes all the space available, but you can use also `frame()` modifier to make it a specific size.

```swift
ZStack {
    Color.red
    Text("Your content")
}
```

Color with specified frame size.

```swift
Color.red.frame(width: 200, height: 200)
```

By default SwiftUI will take all the space that is within `Safe Area`. But you can add `edgesIgnoringSafeArea` modifier to ignore safe area.

```swift
ZStack {
    Color.red.edgesIgnoringSafeArea(.all)
    Text("Your content")
}
```
