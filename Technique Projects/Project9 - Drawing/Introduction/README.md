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

## Paths vs Shapes

In SwiftUI we can draw using paths and shapes. A path is a series of drawing instructions like "start here", "draw a line to here", then add a circle "here", all using an absolute coordinates. In contrast shape has no idea where it will be used or how big it will be, but instead will be asked to draw inside a given rectangle.

```swift
struct ContentView: View {
    @State private var rotate: Double = 0

    var body: some View {
        Triangle()
            .stroke(
                LinearGradient(gradient: Gradient(colors: [.red, .green]), startPoint: .center, endPoint: .bottom), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .frame(width: 300, height: 300)
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}
```

![Triangle Shape](https://i.imgur.com/DVpdDKlm.png)
