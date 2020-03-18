# Core Data

## Saving NSManagedObjectContext changes conditionally

We should always check for uncommitted changes before calling `save()`, to avoid making Core Data work that isn't required.

```swift
if self.moc.hasChanges {
    try? self.moc.save()
}
```

## Ensuring Core Data objects are unique using constraints

This adds multiple Wizards to table, and when you want to save it will save only 1, as it allows only unique data.

```swift
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }

            Button("Save") {
                if self.moc.hasChanges {
                    do {
                        try self.moc.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
```

Add this into `willConnectTo` method after `let context` in `SceneDelegate` file, to set merging policy.

```swift
context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
```

![Core Data unique constraints](https://media.giphy.com/media/QYjuS9wkgwZKQ5G57q/giphy.gif)

## Filtering @FetchRequest using NSPredicate

When we use `@FetchRequest` property wrapper, we can provide an array of sort descriptors to control ordering of results, but we can also provide an `NSPredicate` to control which results should be shown.

In this example can see different `NSPredicate` usage to filter data returned by Core Data.

```swift
struct ShipView: View {
    static var starWarsPredicate = NSPredicate(format: "universe == 'Star Wars'")
    static var starWarsPredicateUpd = NSPredicate(format: "universe == %@", "Star Wars")
    static var defiantPredicate = NSPredicate(format: "name < %@", "F")
    static var universeInAliancePredicate = NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
    static var beginsWithPredicate = NSPredicate(format: "name BEGINSWITH %@", "E")
    static var caseSensitivePredicate = NSPredicate(format: "name BEGINSWITH[c] %@", "e")
    static var notPredicate = NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: beginsWithPredicate) var ships: FetchedResults<Ship>

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                if self.moc.hasChanges {
                    do {
                        try self.moc.save()
                    } catch {
                        print("Failed to save")
                    }
                }
            }
        }
    }
}
```

## Dynamically filtering `@FetchRequest` with SwiftUI

This allows to dynamically filter data from Core Data.

```swift
struct SingersView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"

    var body: some View {
        VStack {

            FilteredList(filter: lastNameFilter)

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }

            Button("Show A") {
                self.lastNameFilter = "A"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}
```

```swift
struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>

    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}
```

![Dynamically filter core data](https://media.giphy.com/media/RJ16PpBupsgAN9tBXK/giphy.gif)
