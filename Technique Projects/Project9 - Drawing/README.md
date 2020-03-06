# Project 9 - Technique Project Drawing

---

## Notes

All notes about techniques used are in [Introduction](https://github.com/Sangsom/100-Days-of-SwiftUI/tree/master/Technique%20Projects/Project9%20-%20Drawing/Introduction) folder.

## Challenges

Updates in `Guess the Flag` project.

✅Create an `Arrow` shape made from a rectangle and a triangle – having it point straight up is fine.

```swift
struct ContentView: View {
    var body: some View {
        Arrow()
            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 300, height: 100)
    }
}

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.66, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.66, y: rect.maxY * 0.66))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY * 0.66))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + (rect.maxY * 0.33)))
        path.addLine(to: CGPoint(x: rect.maxX * 0.66, y: rect.minY + (rect.maxY * 0.33)))
        path.addLine(to: CGPoint(x: rect.maxX * 0.66, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))

        return path
    }
}
```

![Arrow shape](https://i.imgur.com/lQFNHunm.png)

✅Make the line thickness of your `Arrow` shape animatable.

```swift
struct ContentView: View {
    @State private var thickness: CGFloat = 5

    var body: some View {
        VStack {
            Arrow()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: thickness, lineCap: .round
                    , lineJoin: .miter))
                .frame(width: 300, height: 100)

            Stepper("Arrow thickness: \(thickness, specifier: "%.0f")", value: $thickness.animation(.default), in: 1...10)
                .padding(.horizontal)
        }

    }
}
```

![Animated arrow shape thickness](https://media.giphy.com/media/Pidd2Hk958LoTQfK0v/giphy.gif)

✅Create a `ColorCyclingRectangle` shape that is the rectangular cousin of `ColorCyclingCircle`, allowing us to control the position of the gradient using a property.

```swift
struct ContentView: View {
    @State private var colorCycle = 0.0
    @State private var startPoint = "Top"
    @State private var endPoint = "Bottom"

    let points = ["Bottom", "BottomLeading", "BottomTrailing", "Center", "Leading", "Top", "TopLeading", "TopTrailing", "Trailing", "Zero"]

    var startingPoint: UnitPoint {
        switch startPoint {
        case "Bottom":
                return UnitPoint.bottom
        case "BottomLeading":
            return UnitPoint.leading
        case "BottomTrailing":
            return UnitPoint.bottomTrailing
        case "Center":
            return UnitPoint.center
        case "Leading":
            return UnitPoint.leading
        case "Top":
            return UnitPoint.top
        case "TopLeading":
            return UnitPoint.topLeading
        case "TopTrailing":
            return UnitPoint.topTrailing
        case "Trailing":
            return UnitPoint.trailing
        case "Zero":
            return UnitPoint.zero
        default:
            return UnitPoint.zero
        }
    }

    var endingPoint: UnitPoint {
        switch endPoint {
        case "Bottom":
                return UnitPoint.bottom
        case "BottomLeading":
            return UnitPoint.leading
        case "BottomTrailing":
            return UnitPoint.bottomTrailing
        case "Center":
            return UnitPoint.center
        case "Leading":
            return UnitPoint.leading
        case "Top":
            return UnitPoint.top
        case "TopLeading":
            return UnitPoint.topLeading
        case "TopTrailing":
            return UnitPoint.topTrailing
        case "Trailing":
            return UnitPoint.trailing
        case "Zero":
            return UnitPoint.zero
        default:
            return UnitPoint.zero
        }
    }

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: self.colorCycle, startingPoint: startingPoint, endingPoint: endingPoint)
                .frame(width: 200, height: 200)
                .cornerRadius(15)
                .shadow(radius: 5)

            Slider(value: $colorCycle).padding(.horizontal)

            Group {
                Text("Starting point")
                    .font(.title)
                Picker(selection: $startPoint, label: Text("")) {
                    ForEach(points, id: \.self) {
                        Text("\($0)")
                    }
                }
                .background(Color(UIColor.systemTeal))
                .cornerRadius(15)
                .shadow(radius: 5)

                Text("Ending point")
                    .font(.title)
                Picker(selection: $endPoint, label: Text("End Point, \(endPoint)")) {
                    ForEach(points, id: \.self) {
                        Text("\($0)")
                    }
                }
                .background(Color(UIColor.systemTeal))
                .cornerRadius(15)
                .shadow(radius: 5)

            }
            .labelsHidden()
        }
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var startingPoint: UnitPoint
    var endingPoint: UnitPoint

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: self.startingPoint, endPoint: self.endingPoint), lineWidth: 2)
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

![ColorCyclingRectangle](https://media.giphy.com/media/gh5IDirenSHlfVlRvT/giphy.gif)
