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
