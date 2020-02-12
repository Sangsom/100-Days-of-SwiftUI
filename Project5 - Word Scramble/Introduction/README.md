# Introduction

In current project we will review `List`, `Bundle`, `UITextChecker`, and more.

## List

`List` equivalent in UIKit is `UITableView`.

`List`'s job is to provide scrolling data table.

Most basic usage :

```swift
List {
    Text("Static row 1")
    Text("Static row 2")

    ForEach(0..<5) {
        Text("Dynamic row \($0)")
    }

    Text("Static row 3")
    Text("Static row 4")
}
```

We can use `Sections` to separate data logically for readability.

```swift
List {
    Section(header: Text("Section 1")) {
        Text("Static row 1")
        Text("Static row 2")
    }

    Section(header: Text("Section 2")) {
        ForEach(0..<5) {
            Text("Dynamic row \($0)")
        }
    }

    Section(header: Text("Section 3")) {
        Text("Static row 3")
        Text("Static row 4")
    }
}
```

We can use list style to make it look like in settings `UITableView`.

```swift
.listStyle(GroupedListStyle())
```

If we have dynamic content for lists then we can use it like this instead of using `ForEach`.

```swift
List(0..<5) {
    Text("Dynamic row \($0)")
}
```

When working with array of data it needs to know how to identify each row, so we need to use id to help it identify.

```swift
struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        List(people, id: \.self) {
            Text($0)
        }
    }
}
```
