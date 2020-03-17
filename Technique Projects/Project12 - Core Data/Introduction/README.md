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
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
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
