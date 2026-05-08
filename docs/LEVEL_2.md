# Level 2: Making Choices 🛣️

Games are fun because you get to make choices. In code, we use `if` and `else`.

### Your Task
Open your `adventure.rb` file and ask Gemini:
> "I want to add THREE choices now: 'Sword', 'Shield', or 'Magic Wand'. Can you show me how to use `elsif` to handle more than two choices? Also, can you show me how to use a 'Here Document' (triple quotes) to print a cool ASCII art intro for my game?"

### What to look for:
- `if / elsif / else`: These are the "rules" of your game.
- `==`: This is how we check if two things are exactly the same.
- `<<-SQL` or `<<-TEXT`: This is how you start a "Here Document" for big blocks of text.

### Deep Dive:
- **elsif:** Short for "else if". It lets you check many different conditions one by one.
- **Comparison:** We use `==` (two equals) to compare. Ask Gemini why we don't just use one `=`!

### Think about this:
- What happens if you type "SWORD" in all capital letters? Does the computer know it's the same as "sword"? 
- Ask Gemini: "How can I make my code ignore capital letters so 'Sword' and 'sword' both work?"

---
[Next: Level 3 - The Game Loop](./LEVEL_3.md)
