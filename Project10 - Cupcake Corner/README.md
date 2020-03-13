# Cupcake Corner

This app allows to make an custom Cupcake and order it.

## Notes

All notes about techniques used are in [Introduction](https://github.com/Sangsom/100-Days-of-SwiftUI/tree/master/Project10%20-%20Cupcake%20Corner/Introduction) folder.

## Challenges

✅Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.  
✅If our call to `placeOrder()` fails – for example if there is no internet connection – show an informative alert for the user. To test this, just disable WiFi on your Mac so the simulator has no connection either.  
✅For a more challenging task, see if you can convert our data model from a class to a struct, then create an `ObservableObject` class wrapper around it that gets passed around. This will result in your class having one `@Published` property, which is the data struct inside it, and should make supporting `Codable` on the struct much easier.

![Cupcake Corner](https://media.giphy.com/media/RhYQUrGyemMA3wfh8q/giphy.gif)
