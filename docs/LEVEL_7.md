# Level 7: Symbols and Secrets (Symbols) 💎

In Ruby, we often use **Symbols** instead of Strings for keys. They look like this: `:forest`.

### Your Task
Ask Gemini:
> "What is the difference between a String `"forest"` and a Symbol `:forest`? Can you show me how to rewrite my world map Hash using Symbols? Explain why Symbols are faster for the computer."

### What to look for:
- `:name`: The colon at the beginning makes it a Symbol.
- `status = :playing`: This is a great way to keep track of the game's "State" (is the player :alive, :dead, or :winner?).

### Deep Dive:
- **Immutability:** Symbols can't be changed once they are made. This makes them very reliable for names and labels in your code.

### Think about this:
- How would you use a variable called `current_state` to decide if the game loop should keep running? 
- `while current_state == :playing`. Ask Gemini to explain this logic!

---
[Next: Level 8 - The Roll of the Dice (Randomness)](./LEVEL_8.md)
