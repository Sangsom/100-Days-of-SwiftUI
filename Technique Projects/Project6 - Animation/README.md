# Animations

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

## Customizing animations

### Spring animations

This will make button scale up quickly and then bounce.

```swift
.animation(.interpolatingSpring(stiffness: 50, damping: 1))
```

![Spring animation](https://media.giphy.com/media/JQ4X1D9cOCjkXMvFzy/giphy.gif)

Also we can adjust animation duration like:

```swift
.animation(.easeOut(duration: 2))
```

When we say `.animation(.easeOut(duration: 2))` we are creating an instance of an `Animation` struct that has its own set of modifiers. So we can attach modifiers directly to the animation to add a delay like this.

```swift
.animation(
    Animation.easeInOut(duration: 2)
        .delay(1)
)
```

![Animation Delay](https://media.giphy.com/media/iJDDzX06luFiOPLfMA/giphy.gif)

This will play animation 3 times and reverse it.

```swift
.animation(
    Animation.easeInOut(duration: 1)
        .repeatCount(3, autoreverses: true)
)
```

This repeats animation forever.

```swift
.animation(
    Animation.easeInOut(duration: 1)
        .repeatForever(autoreverses: true)
)
```

This makes a pulse effect of button

```swift
Button("Tap Me") {
    // self.animationAmount += 1
}
.padding(40)
.background(Color.red)
.foregroundColor(.white)
.clipShape(Circle())
.overlay(
    Circle()
        .stroke(Color.red)
        .scaleEffect(animationAmount)
        .opacity(Double(2 - animationAmount))
        .animation(
            Animation.easeOut(duration: 1)
                .repeatForever(autoreverses: false)
        )
)
.onAppear {
    self.animationAmount = 2
}
```

![Pulsing Button](https://media.giphy.com/media/cmU2FPTevGnyzZl4lS/giphy.gif)

## Animating bindings

`animation()` modifier can be applied to any SwiftUI binding, that allows to animate value between current and new one.

This animates button scale when tapping on stepper.

```swift
struct ContentView: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

            Spacer()

            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}
```

![Animating button scale](https://media.giphy.com/media/StdBSbIFdAVeIKvojy/giphy.gif)

We can also use it with `animation modifiers` like this:

```swift
Stepper("Scale amount", value: $animationAmount.animation(
    Animation.easeInOut(duration: 1)
        .repeatCount(3, autoreverses: true)
), in: 1...10)
```

## Explicit animations

Explicit animations are animations that are happening as a result of a state change.

In explicit animations you add `withAnimation()` closure to ensure that changes are animated.s

```swift
struct ContentView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}
```

![Explicit Animation](https://media.giphy.com/media/PmALLrgE88vya98BuS/giphy.gif)
