# Level 1: The Magic Echo 🗣️

In programming, the first thing we do is make the computer speak. In Ruby, we use `puts`.

### Your First Task
1. Open your terminal in this folder.
2. Type `code adventure.rb` to open a new file in VS Code.
3. In your terminal, type `gemini` followed by your question in quotes:
   > `gemini "I am learning Ruby. Can you write a code that asks for my name AND my age? Then, make the computer calculate what year I will turn 100 years old. Please explain how to turn text into a number."`

### What to look for:
- `puts`: This prints text to the screen.
- `gets.chomp`: This waits for you to type something. `chomp` removes the "Enter" key press from the end.
- `#{name}`: This is a placeholder that puts your variable inside a sentence.

### Deep Dive:
- **Variables:** Think of `name` or `age` as small boxes where the computer stores information.
- **Integers vs Strings:** The computer sees "12" as text (a String), but it needs it to be a number (an Integer) to do math. In Ruby, we use `.to_i` (to integer) to fix this!

### Think about this:
- What happens if you try to add two names together (like `"Hello" + "World"`)? 
- What happens if you try to add a name and a number without using `.to_i`? Try it and ask Gemini why it crashed!

---
[Next: Level 2 - Making Choices](./LEVEL_2.md)
