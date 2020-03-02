# Drawing

## Custom paths with SwiftUI

SwiftUI gives us a dedicated `Path` type for drawing custom shapes.

Just like colors, gradients, and shapes, paths are views in their own right.

```swift
struct ContentView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
        }
        .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round)).opacity(0.25)
    }
}
```

![Triangle drawing](https://media.giphy.com/media/if4Sojg5lNmQnnz26y/giphy.gif)
