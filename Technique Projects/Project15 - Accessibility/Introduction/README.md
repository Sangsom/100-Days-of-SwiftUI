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
