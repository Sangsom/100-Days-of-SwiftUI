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
