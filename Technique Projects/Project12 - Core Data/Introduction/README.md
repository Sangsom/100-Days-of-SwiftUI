# Core Data

## Saving NSManagedObjectContext changes conditionally

We should always check for uncommitted changes before calling `save()`, to avoid making Core Data work that isn't required.

```swift
if self.moc.hasChanges {
    try? self.moc.save()
}
```
