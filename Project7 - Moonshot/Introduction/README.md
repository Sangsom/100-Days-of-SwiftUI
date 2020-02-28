# Introduction

In this app we will review usage of `GeometryReader`, `ScrollView`, `NavigationLink`, and more.

## Resizing images to fit the screen using GeometryReader

Here we use `GeometryReader` to set image width to a device width. Whatever it is.

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width)
            }
        }
    }
}
```

## Data in ScrollView

Here we create a vertical scroll view what shows a list of numbers from 0 to 100.

```swift
struct ContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                ForEach(0..<100) {
                    Text("Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
```

## Pushing new views onto the stack using NavigationLink

`NavigationView` shows for us navigation bar at the top of our views,and also it lets us push views onto a view stack.

```swift
NavigationView {
    List(0..<100) { row in
        NavigationLink(destination: Text("Detail \(row)")) {
            Text("Row \(row)")
        }
    }
    .navigationBarTitle("SwiftUI")
}
```
