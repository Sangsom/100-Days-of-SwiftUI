# Word Scramble

This project is a game that shows players a random eight-letter word and ask them to make words out of it. For example, if the starter word is "shortest" they might spell "short", "test", "set" and so.

## Notes

All notes about techniques used are in [Introduction](https://github.com/Sangsom/100-Days-of-SwiftUI/tree/master/Project5%20-%20Word%20Scramble/Introduction) folder.

## Challenges

- ✅ Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into `isReal()` that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.
- ✅ Add a left bar button item that calls `startGame()`, so users can restart with a new word whenever they want to.
- ✅ Put a text view below the `List` so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.

![Word Scramble](https://media.giphy.com/media/ZXB0riw362FZCcjO0s/giphy.gif)
