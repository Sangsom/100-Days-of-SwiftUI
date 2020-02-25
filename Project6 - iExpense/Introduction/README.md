# Introduction

In this project we will learn about `@ObservedObject`, `sheet()`, `onDelete()`, and more.

## Why @State only works with structs

`State` property wrapper is designed for simple data that is local to the current view, but as soon as you want to share data between views it stops being useful.

## Sharing SwiftUI state with `@ObservedObject`

If you want to that data should be shared across more than one view we should use Class - then SwiftUI gives us two property wrappers `@ObservedObject` and `@EnvironmentObject`.

In this example we have a User class with two properties, and if we want to notify any views that are watching our class for changes in these properties, so they can be reloaded, we need to use `@Published` property observer like this:

```swift
class User {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}
```

Next we need to notify our views about these changes. And that's another property wrapper `@ObservedObject` - it tells SwiftUI to watch a class for any changes.

```swift
@ObservedObject var user = User()
```

In order to use `@ObservedObject`, class must conform to `ObservableObject` protocol.

```swift
class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}
```

### Usage

---

So if we want to create sharable state we need to take 3 steps:

- Make a class that conforms to `ObservableObject` protocol
- Mark some properties with `@Published` so that any views using the class get updated when they change.
- Create an instance of class using `@ObservedObject` property wrapper.

## Showing and hiding Views with `.sheet()`

```swift
struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode

    var name: String

    var body: some View {
        VStack {
            Text("Hello \(name)")
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Rinalds Domanovs")
        }
    }
}
```

![Sheet usage](https://media.giphy.com/media/j5mn2ZqZxamrNDJfNT/giphy.gif)

## Deleting items using `onDelete()`

`onDelete()` modifier is used to control how objects should be deleted from collection. Usually it will be used with `List` and `ForEach`.

> `onDelete()` exists only on `ForEach`.

```swift
struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }

                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}
```

## Storing settings with UserDefaults

`UserData` allows us to store small amount of user data. Suggested is to store data that is no more than `512KB`in there.

`UserData` is perfect for storing user settings that might track when the user last launched app, which news story they last read, or other passively collected information.

In this example we are saving user tap count in `UserDefaults` and when app is launched tapCount is loaded from there too.

```swift
struct ContentView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

    var body: some View {
        Button("Tap count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}
```

## Archiving Swift objects with Codable

We can archive custom type so we can put it into `UserDefaults`, then unarchive it when comes back out from `UserDefaults` with `Codable`.

When we are working with a custom type that only has simple properties - strings, integers, Booleans, arrays of strings, and so on - the only thing we need to do to support archiving and unarchiving is to add a conformance to `Codable`.

```swift
struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Rinalds", lastName: "Domanovs")

    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()

            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}
```
