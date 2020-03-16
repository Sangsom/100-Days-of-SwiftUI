# Introduction

Here we will learn about `@Binding`, `type erasure`, `Core Data`, and more.

## Custom component with `@Binding`

`@Binding` lets us connect an `@State` property of one view to some underlying model data.

```swift
struct ContentView: View {
    @State private var rememberMe = false

    var body: some View {
        Toggle(isOn: $rememberMe) {
            PushButton(title: "Remember Me", isOn: $rememberMe.animation())
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}
```

![Binding usage](https://media.giphy.com/media/IbkflevgKCUeiupyGE/giphy.gif)

## Using size classes with AnyView type erasure

Size classes are Apple's way of telling us how much space we have for our views.

It allows to return different view depending on sizeClass.

```swift
struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}
```

## Core Data and SwiftUI

Setting up Core Data requires two steps:

- Creating a _persistent container_ - that loads and saves actual data from device storage.
- Injecting that into the SwiftUI environment so that all our views can access it.

**Both of these steps are already done for us by the Xcode template.**

Retrieving information from Core Data is done using a _fetch request_ - we describe what we want, how it should sorted, and whether any filters should be used, and Core Data sends back all the matching data.

This sample code generates random users and saves into Core Data and shows in List.

```swift
struct ContentView: View {
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }

            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                // more code to come
                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"

                try? self.moc.save()
            }
        }
    }
}
```
