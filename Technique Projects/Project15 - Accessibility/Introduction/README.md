# Accessibility

## View identification with labels

By adding accessibility labels we can make reader read custom names so instead of long picture names it will read short label like Tulip.

And by adding accessibility traits we can force to read is a different object. As in this case by default this button is read as an image, because it uses Image, but here we add trait for a button, and it will be then read as a button by VoiceOver.

```swift
struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]

    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]

    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .accessibility(label: Text(labels[selectedPicture]))
            .accessibility(addTraits: .isButton)
            .onTapGesture {
                self.selectedPicture = Int.random(in: 0...3)
        }
    }
}
```

## Hiding and grouping accessibility data

You can hide individual views from VoiceOver.

```swift
Image(decorative: "character")
    .accessibility(hidden: true)
```

You can also group views, in this case by grouping VStack - VoiceOver will read both Text views as a one.

```swift
VStack {
    Text("Your score is")
    Text("1000")
        .font(.title)
}.accessibilityElement(children: .combine)
```

By default, when Voice Over will read grouped views there will be pause between each view, so in this example we want to ignore the pause read and add custom label to read it without any delay.

```swift
VStack {
    Text("Your score is")
    Text("1000")
        .font(.title)
}
.accessibilityElement(children: .ignore)
.accessibility(label: Text("Your score is 1000"))
```

## Reading values from controls

By default, VoiceOver will read a Slider values in %, but we can change it to read just a number like this.

```swift
struct ContentView: View {
    @State private var estimate = 25.0

    var body: some View {
        Slider(value: $estimate, in: 0...50)
        .padding()
        .accessibility(value: Text("\(Int(estimate))"))
    }
}
```

Here we can adjust how VoiceOver will read values after they are changed.

```swift
struct ContentView: View {
    @State private var rating = 3

    var body: some View {
        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
            .accessibility(value: Text("\(rating) out of 5"))
    }
}
```
