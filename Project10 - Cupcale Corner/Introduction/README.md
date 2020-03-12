# Introduction

In this app we will look more about `Codable`, `URLSession`, `disabled()` modifier and more.

## Codable conformance for @Published properties

By default if we want to add `Codable` conformance for `@Published` properties, Swift doesn't allow that and we need to add extra work.

We need to implement `Codable` conformance by self.

First we need to create a `CodingKeys` enum that conforms to `CodingKey`, listing all the properties we want to archive and unarchive.

And then create a custom initializer that will be used to read values for all our properties.

```swift
class User: ObservableObject, Codable {
    @Published var name = "Rinalds Domanovs"

    enum CodingKeys: CodingKey {
        case name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
```

## Sending and receiving Codable data with URLSession and SwiftUI

This fetches iTunes API and loads data to UI.

```swift
struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.self.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }

    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data - go back to main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.results = decodedResponse.results
                    }

                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there are a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
```

## Validating and disabling forms

This disables form button unless both username and email are validated and true

```swift
struct ContentView: View {
    @State private var username = ""
    @State private var email = ""

    var disabledForm: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disabledForm)
        }
    }
}
```
