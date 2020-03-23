# Project 12 - Core Data

## Notes

All notes about techniques used are in [Introduction](https://github.com/Sangsom/100-Days-of-SwiftUI/tree/master/Technique%20Projects/Project12%20-%20Core%20Data/Introduction) folder.

## Challenges

✅Make it accept an array of `NSSortDescriptor` objects to get used in its fetch request.

```swift
struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}
```

✅Make it accept a string parameter that controls which predicate is applied. You can use Swift’s string interpolation to place this in the predicate.

```swift
init(filterKey: String, filterValue: String, predicate: String, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
    fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
    self.content = content
}
```

✅ Modify the predicate string parameter to be an enum such as .beginsWith, then make that enum get resolved to a string inside the initializer.

```swift
enum Predicate: String {
    case beginsWith, endsWith
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, predicate: Predicate, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}
```

## Codable Keys

Sometimes we would need to translate incoming `JSON` property names that are written in snake case `first_name` to camelCase `firstName`.
Codable is able to translate between these two as long as it knows what to expect - we need to set a property on our decoder called `keyDecodingStrategy`.

```swift
struct User: Codable {
    var firstName: String
    var lastName: String
}
```

```swift
let str = """
{
    "first_name": "Andrew",
    "last_name": "Glouberman"
}
"""

let data = Data(str.utf8)
```

Decoding;

```swift
do {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    let user = try decoder.decode(User.self, from: data)
    print("Hi, I'm \(user.firstName) \(user.lastName)")
} catch {
    print("Whoops: \(error.localizedDescription)")
} 
```

There may be also cases when our data is named totally different as we need, and we need to re-name them:

```swift
let str = """
{
    "first": "Andrew",
    "last": "Glouberman"
}
"""
```

```swift
struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
    }

    var firstName: String
    var lastName: String
}
```