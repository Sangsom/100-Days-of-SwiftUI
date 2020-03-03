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

This creates an arc and it has adjusted rotation to start from top.

```swift
struct ContentView: View {
    @State private var rotate: Double = 0

    var body: some View {
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
            .stroke(Color.red, lineWidth: 10)
            .frame(width: 300, height: 300)
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: clockwise)

        return path
    }


}
```

![Imgur](https://i.imgur.com/CRfw3jGm.png)

## Transforming shapes using CGAffineTransform`

```swift
struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0

    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//            .stroke(Color.red, lineWidth: 1)
                .fill(Color.green, style: FillStyle(eoFill: true))

            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])

            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20

    // How wide to make each petal
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()

        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // rotate the patal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)

            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))

            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)

            // add it to our main path
            path.addPath(rotatedPetal)
        }

        // now send the main path back
        return path
    }
}
```

![Flower Shape](https://media.giphy.com/media/WOwPrHBWjYsLQ07WHF/giphy.gif)
