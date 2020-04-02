# Introduction

## Adding conformance to Comparable for custom types

Here we conformed `User` struct to a `Comparable` protocol in order to enable for it sorting.
We can make whatever we want sorting conditions.

```swift
struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String

    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}
```

## Writing data to the documents directory

This allows to save text into message.txt file and save in apps documents directory.

```swift
struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = self.getDocumentsDirectory().appendingPathComponent("message.txt")

                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
        }
    }

    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
```
