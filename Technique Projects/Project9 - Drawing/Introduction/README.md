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

## Creative borders and fills using ImagePaint

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello World")
            .frame(width: 300, height: 300)
            .border(ImagePaint(image: Image("image"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.2), width: 30)

            Capsule()
                .strokeBorder(ImagePaint(image: Image("image"), scale: 0.1), lineWidth: 20)
                .frame(width: 300, height: 200)
        }
    }
}
```

![Imgur](https://i.imgur.com/neGDx09m.png)

## Enabling Metal rendering with drawingGroup()

By default SwiftUI uses Core Animation for it's rendering.

```swift
struct ContentView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)


            Slider(value: $colorCycle)
        }
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
//                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}
```

![drawingGroup Animation](https://media.giphy.com/media/QVbTycfRgK9cvEN174/giphy.gif)

## Special effects in SwiftUI: blurs, blending, and more

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Image("image")
                .resizable()
                .scaledToFit()

            Rectangle()
                .fill(Color.red)
                .blendMode(.multiply)
        }
        .frame(width: 300, height: 200)
        .clipped()
    }
}
```

This can be rewritten using `.colorMultiply` modifier.

```swift
Image("image")
    .resizable()
    .scaledToFit()
    .colorMultiply(.red)
```

![Multiple Color Blending](https://i.imgur.com/YUCwBvZm.png)

```swift
struct ContentView: View {
    @State private var amount: CGFloat = 0.0

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)

            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}
```

![Screen blending](https://media.giphy.com/media/Y0a7QswnsupV27TexU/giphy.gif)

## Animating simple shapes

```swift
struct ContentView: View {
    @State private var insetAmount: CGFloat = 50

    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    self.insetAmount = CGFloat.random(in: 10...90)
                }
        }
    }
}

struct Trapezoid: Shape {
    var insetAmount: CGFloat
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
    }
}
```

![Animating simple shape](https://media.giphy.com/media/SVHsPCIzrH3fFgJQAQ/giphy.gif)
