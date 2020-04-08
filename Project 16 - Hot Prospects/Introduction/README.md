# Introduction

## Reading custom values from the environment with `@EnvironmentObject`

We can share or use values in Views without needing to pass it through all the child views.

We need to create an `@EnvironmentObject` for the property in View you want to use.

And we can add it by using `.environmentObject()`.

```swift
class User: ObservableObject {
    @Published var name = "Rinalds Dom"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    let user = User()

    var body: some View {
        VStack {
            EditView().environmentObject(user)
            DisplayView().environmentObject(user)
        }
    }
}
```

## Creating TabView

```swift
struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    self.selectedTab = 1
            }
                .tabItem {
                    Image(systemName: "star")
                    Text("One")
            }
            .tag(0)

            Text("Tab 2")
                .onTapGesture {
                        self.selectedTab = 2
                }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Two")
            }
            .tag(1)
        }
    }
}
```

## Swifts `Result` type
