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

## Swift's `Result` type

```swift
enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
        .onAppear {
            self.fetchData(from: "https://www.apple.com") { result in
                switch result {
                case .success(let str):
                    print(str)
                case .failure(let error):
                    switch error {
                    case .badURL:
                        print("Bad URL")
                    case .requestFailed:
                        print("Network problems")
                    case .unknown:
                        print("Unknown error")
                    }
                }
            }
        }
    }

    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        // check the URL is OK, otherwise return with a failure
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            // the task has completed – push our work back to the main thread
            DispatchQueue.main.async {
                if let data = data {
                    // success: convert the data to a string and send it back
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    // any sort of network failure
                    completion(.failure(.requestFailed))
                } else {
                    // this ought not to be possible, yet here we are
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}
```

## Manually publishing ObservableObject changes

```swift
class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}
```

## Context Menu

![Context menu](https://media.giphy.com/media/VDHFV9608mjnQf3JyC/giphy.gif)
