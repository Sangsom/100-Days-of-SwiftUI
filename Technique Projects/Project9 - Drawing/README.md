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

✅Create a `ColorCyclingRectangle` shape that is the rectangular cousin of `ColorCyclingCircle`, allowing us to control the position of the gradient using a property.
