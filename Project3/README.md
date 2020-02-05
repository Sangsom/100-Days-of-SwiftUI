# Project 3 - Technique

---

## Challenges

- ✅Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.

```swift
struct ContentView: View {
    var body: some View {
        Text("A large, blue font")
            .largeTitleStyle()
    }
}

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.blue)
    }
}

extension View {
    func largeTitleStyle() -> some View {
        self.modifier(LargeTitle())
    }
}

```

- ✅Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.

```swift
Section(header: Text("Total amount for the check")) {
    Text("$\(totalAmount, specifier: "%.2f")")
        .foregroundColor(tipPercentage == 4 ? .red : .none)
}
```

![WeSplit](https://media.giphy.com/media/M9N73iOkDMYJFNoOrc/giphy.gif)

- ✅Go back to project 2 and create a FlagImage() view that renders one flag image using the specific set of modifiers we had.
