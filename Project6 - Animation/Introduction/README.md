# Introduction

## Implicit animations

We tell our views ahead of time to animate something.

```swift
struct ContentView: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        Button("Tap Me") {
            self.animationAmount = CGFloat.random(in: 0.5...2)
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.default)
        .blur(radius: (animationAmount - 1) * 3)
    }
}
```

![Implicit animation](https://media.giphy.com/media/fqhlnAApoMr5Kd56jm/giphy.gif)
