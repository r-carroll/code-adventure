# Level 3: The Infinite Loop 🔄

What if you want the game to keep going until the player wins or loses? For that, we use a `loop`.

### Your Task
Ask Gemini:
> "I want to add 'Health Points' (HP) to my game. Can you show me a loop where every time the player chooses to 'Explore', they might lose 10 HP? The loop should stop if they type 'quit' OR if their HP reaches 0. Explain how to combine these two conditions using `||` (OR) or `&&` (AND)."

### What to look for:
- `while` or `loop`: These tell the computer to repeat code.
- `break`: This is the "Emergency Exit" for a loop.
- `&&` (AND) / `||` (OR): These are used to combine rules.

### Deep Dive:
- **Booleans:** Conditions like `hp > 0` are either **True** or **False**. These are called Booleans.
- **Compound Logic:** Using `&&` and `||` allows you to make complex rules (e.g., "If you have a key AND you are at the door...").

### Think about this:
- Can you make a loop that counts *up* to 10?
- What happens if you forget to add a `break`? (Don't worry, you can stop a stuck program by pressing `Ctrl + C` in your terminal!)

---
[Next: Level 4 - Clean Code with Methods](./LEVEL_4.md)
