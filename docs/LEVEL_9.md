# Level 9: Saving the Story (File I/O) 💾

What if your player wants to stop playing and come back later? You need to save their progress to a file!

### Your Task
Ask Gemini:
> "How can I save the player's name and HP to a text file called `save.txt`? Also, show me how to read that file when the game starts so the player can continue their adventure."

### What to look for:
- `File.write("save.txt", data)`: This creates a file and puts data in it.
- `File.read("save.txt")`: This grabs the data back out.

### Deep Dive:
- **Persistence:** This is a big word that means "data that stays around even when the power goes off." Files are the most basic way to achieve persistence.

### Think about this:
- What happens if the `save.txt` file doesn't exist yet? Ask Gemini how to use `File.exist?` to prevent your game from crashing!

---
[Next: Level 10 - Your Ultimate Quest!](./LEVEL_10.md)
