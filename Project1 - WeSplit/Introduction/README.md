# Introduction

In current we will review `Form`, `NavigationView`, `@State`, and more...

This is initially generated sample code.

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

`struct ContentView: View` creates a new struct that conforms to a `View` protocol.

`View` comes from `SwiftUI` and is the basic protocol that should be adopted by anything we want to create on screen (Buttons, Text, images, views etc).

`var body: some View` means that it must return something that conforms to a `View` protocol, and `some` keyword says that it always must be returned the same kind of view.

## Creating a form

In SwiftUI are `Form` view that are scrolling lists of static controls like text and images.

In `Form`'s you can have as many items as you want, but you shouldn't add more than 10. If you need more then you need to use groups.

```swift
var body: some View {
    Form {
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
    }
}
```

### Groups

```swift
Form {
    Group {
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
    }

    Group {
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
    }
}
```

### Sections

If you want a visual differences splitting elements in form, then you need to use `Sections`.

```swift
Form {
    Section {
        Text("Hello World")
    }

    Section {
        Text("Hello World")
        Text("Hello World")
    }
}
```

## Navigation Bar

Adding navigation bar.

```swift
var body: some View {
    NavigationView {
        Form {
            Section {
                Text("Hello World")
            }
        }
    }
}
```

You can add a title to navigation bar and this can be done by attaching _modifier_ wherever you've placed inside.

`Modifiers` are a regular methods that always return a `new instance` of whatever you use them on.

```swift
var body: some View {
    NavigationView {
        Form {
            Section {
                Text("Hello World")
            }
        }
    .navigationBarTitle(Text("SwiftUI"))
    }
}
```

> Tip: When we attach `.navigationBarTitle()` modifier to our form, Swift actually creates a new form that has a navigation bar title plus all existing contents you provided.

You can set title small instead of large.

```swift
.navigationBarTitle(Text("SwiftUI"), displayMode: .inline)
```

## Modifying program state

> Views are a function of their state.

The way how UI looks, how people see your app and how they can interact is determined by the `state of your program`.

### Property Wrapper

Swift allows to store program state in property wrappers that in SwiftUI is called `@State`.

```swift
struct ContentView: View {
    @State var tapCount = 0

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
        }
    }
}
```

> Tip: Apple recommends to add `private` access control for `@State` property wrappers.

```swift
@State private var tapCount = 0
```

## State binding

In this example we create a `TextField`. In SwiftUI for `TextField`'s to be able to work in needs to bind a state. That is in order to show a current value it needs to read it from somewhere, and in order to save a value it needs a to save it somewhere.

It's called _two-way biding_: we bind the text field so that it shows the value of our property, but we also bind it so that any changes to the text field also updates the property.

```swift
struct ContentView: View {
    @State private var name = ""

    var body: some View {
        Form {
            TextField("Enter your name", text: $name)
            Text("You name is \(name)")
        }
    }
}
```

## Custom bindings

Sample of custom binding that just stores the value away in another `@State` property and reads it back.

```swift
struct ContentView: View {
    @State var selection = 0

    var body: some View {
        let binding = Binding(
            get: { self.selection },
            set: { self.selection = $0 }
        )

        return VStack {
            Picker("Select a number", selection: binding) {
                ForEach(0 ..< 3) {
                    Text("Item \($0)")
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}
```

Advanced use of custom bindings.

```swift
struct ContentView: View {
    @State var agreedToTerms = false
    @State var agreedToPrivacyPolicy = false
    @State var agreedToEmails = false

    var body: some View {
        let agreedToAll = Binding<Bool>(
            get: {
                self.agreedToTerms && self.agreedToPrivacyPolicy && self.agreedToEmails
            },
            set: {
                self.agreedToTerms = $0
                self.agreedToPrivacyPolicy = $0
                self.agreedToEmails = $0
            }
        )

        return VStack {
            Toggle(isOn: $agreedToTerms) {
                Text("Agree to terms")
            }

            Toggle(isOn: $agreedToPrivacyPolicy) {
                Text("Agree to privacy policy")
            }

            Toggle(isOn: $agreedToEmails) {
                Text("Agree to receive shipping emails")
            }

            Toggle(isOn: agreedToAll) {
                Text("Agree to all")
            }
        }
    }
}
```

## Creating views in loop

We can create as much views in SwiftUi with `ForEach` loop.

```swift
Form {
    ForEach(0 ..< 100) { number in
        Text("Row \(number)")
    }
}
```

We can also use a shorthand syntax:

```swift
Form {
    ForEach(0 ..< 100) {
        Text("Row \($0)")
    }
}
```

It's useful to use for `Picker` views:

```swift
struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = 0

    var body: some View {
        VStack {
            Picker("Select your student", selection: $selectedStudent) {
                ForEach(0 ..< students.count) {
                    Text(self.students[$0])
                }
            }
            Text("You chose: Student # \(students[selectedStudent])")
        }
    }
}
```

![Picker View](https://i.imgur.com/6fnc5MH.png)
