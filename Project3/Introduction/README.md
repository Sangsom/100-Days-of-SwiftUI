# Introduction

In current technique project we will see how to build `custom view modifiers`, `custom containers`, and more.

## Views and modifiers

Reasons of why in `SwiftUI` are used structs instead of classes.

- Structs are simpler and faster than classes.
- In SwiftUI all views are just structs, holding only those attributes, properties that you defined, they don't inherit everything like in UIKit.
- By creating views with structs, it forces us to think about isolating state in a clean way.
