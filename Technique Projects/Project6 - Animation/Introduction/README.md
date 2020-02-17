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

## Controlling animation stack

Here we demonstrate how order of applied animations matters, the same like applying modifiers for views.

```swift
struct ContentView: View {
    @State private var enabled = false

    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.red)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.default)

    }
}
```

![Animating button](https://media.giphy.com/media/IhCeBzPf9vc0SUHldw/giphy.gif)

We can apply multiple `animation()` modifiers, to control each animation separately.

```swift
Button("Tap Me") {
    self.enabled.toggle()
}
.frame(width: 200, height: 200)
.background(enabled ? Color.blue : Color.red)
.animation(.default)
.foregroundColor(.white)
.clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
.animation(.interpolatingSpring(stiffness: 10, damping: 1))
```

![Multiple animation modifiers](https://media.giphy.com/media/lOTXln6Uth0b3Am8Qs/giphy.gif)

Additionally we can disable completely animations by disabling `nil` to modifier. For example like here we would disable animating background color but to change it immediately we just pass `nil` to animation modifier.

```swift
Button("Tap Me") {
self.enabled.toggle()
}
.frame(width: 200, height: 200)
.background(enabled ? Color.blue : Color.red)
.animation(nil)
.foregroundColor(.white)
.clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
.animation(.interpolatingSpring(stiffness: 10, damping: 1))
```

## Animating gestures

In `SwiftUI` we can attach gestures to any views, and also they can be animated.

In this example we have added `DragGesture()` to view and updating it's offset when dragging. When drag has ended, view is returning back to a zero point, which in this case is explicitly animated with `.withAnimation`.

```swift
struct ContentView: View {
    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
        .frame(width: 300, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .offset(dragAmount)
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        self.dragAmount = .zero
                    }
            }
        )
    }
}
```

![Animating DragGesture](https://media.giphy.com/media/Wse2Iov8V8Ogy6VoXh/giphy.gif)

In this sample we are adding arrays of letters and attaching `DragGesture()`. Resulting that when we are dragging letters, to them are added animation delay and making a nice snake effect, and when the dragging has over, it updates background color.

```swift
struct ContentView: View {
    let letters = Array("Rinalds Domanovs")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
            }
        )
    }
}
```

![Animating letters](https://media.giphy.com/media/ZBKDF33vbaUR4phEsh/giphy.gif)

## Showing and hiding views with transitions

Here we are animating rectangle view to show and hide.

```swift
struct ContentView: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .slide))
            }
        }
    }
}
```

![Animating transition](https://media.giphy.com/media/fAJvS4UfZicboNuev8/giphy.gif)

## Building custom transitions using ViewModifier

We can create completely new transitions in `SwiftUI`, by using `.modifier` transition, that accepts any view modifier we want.

Here we need to create struct that defines effects..

```swift
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}
```

And then we can wrap that inside a `AnyTransition` extension, making it rotate from -90 to 0 on its top leading corner:

```swift
extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}
```

And use this transition for any view:

```swift
if isShowingRed {
    Rectangle()
        .fill(Color.red)
        .frame(width: 200, height: 200)
        .transition(.pivot)
}
```

![Custom pivot transition](https://media.giphy.com/media/hUFdIriaLWTkt5CbiD/giphy.gif)
