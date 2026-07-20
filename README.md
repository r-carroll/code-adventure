🇯🇵 [日本語版](./README_JA.md) ・ 🇬🇧 English

# Code Adventure 🚀

Welcome, adventurer! You're about to build your very own text adventure game — with an AI tutor by your side to help you learn **Ruby** (a real coding language) one small step at a time.

No experience needed. No terminal experience needed. Just curiosity.

---

## ⚡ Fastest Start: GitHub Codespaces

The easiest way to start — no installing anything on your own computer.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/r-carroll/code-adventure) [![Resume Codespace](https://img.shields.io/badge/Resume_Codespace-238636?style=for-the-badge&logo=github)](https://github.com/codespaces)

1. **First time?** Click **Open in GitHub Codespaces**. **Returning?** Click **Resume Codespace**. *(Tip: **Cmd+Click** or **Ctrl+Click** to open in a new tab!)*
2. Wait a minute or two while your adventure loads in the cloud. ☁️
3. When it's ready, look at the bottom of the screen for a panel called **Terminal**. Click into it.
4. Type this and press **Enter**:
   ```
   ruby quest.rb
   ```
5. Your quest begins! 🎉

That's it. Your AI coding tutor (`claude` and `agy`) is already installed and waiting for you in this Codespace — jump to **Opening Your AI Tutor** below to start chatting with it.

---

<details>
<summary>🛠 Prefer to run it on your own computer? Click here for local setup</summary>

### 1. Get the code
- Go to the [Code Adventure page on GitHub](https://github.com/r-carroll/code-adventure).
- Click the **"<> Code"** button, then **"Download ZIP"**.
- Unzip it and move the folder somewhere easy to find, like your Desktop.

> **Know Git already?** `git clone https://github.com/r-carroll/code-adventure.git`

### 2. Install Ruby
- **Windows:** Get **Ruby+Devkit 3.3.x (x64)** from [RubyInstaller.org](https://rubyinstaller.org/). Click "Next" through the installer.
- **Mac:** Open Terminal and run `brew install ruby` (needs [Homebrew](https://brew.sh)).

### 3. Install an AI coding CLI
Pick one — you only need one:
- [Antigravity CLI](https://antigravity.google/product/antigravity-cli)
- [Claude Code](https://claude.com/claude-code)

Nice part: you don't need to paste any instructions to "train" it. This repo already contains `AGENTS.md` and `CLAUDE.md` — whichever tool you use loads its tutor rules automatically the moment you run it in this folder. Your AI already knows how to be a good teacher for this project.

### 4. Open a terminal
- **Windows:** Press the Windows key, type `cmd`, press Enter.
- **Mac:** Open the **Terminal** app (search for it with Spotlight).
- Type `cd ` (with a space), then drag your `code-adventure` folder into the window, then press Enter.

### 5. Start your quest
```
ruby quest.rb
```

Next, check out **Opening Your AI Tutor** below — it walks you through actually starting a chat with your coding partner.

</details>

---

## 🧑‍🏫 Opening Your AI Tutor

`ruby quest.rb` shows you *what* to build. Your AI tutor is *who* helps you actually write it. Here's exactly how to open it and start talking — step by step, no guessing.

### Step 1: Open a second terminal

You want **two terminals** side by side: one running your quest, one for chatting with your AI tutor.

- **In GitHub Codespaces (or VS Code):** Look at the Terminal panel at the bottom of your screen. In its top-right corner, find the **split terminal** icon — two little rectangles side by side — and click it. A second terminal opens right next to your first one.
- **On Windows:** Press the Windows key, type `PowerShell`, and press Enter to open another window.
- **On Mac:** With Terminal already open, press `Cmd + T` for a new tab (or `Cmd + N` for a whole new window).

You can always open more later — you won't break anything.

### Step 2: Wake up your AI tutor

Click into your **new** terminal (leave the one running `ruby quest.rb` alone) and type the command for whichever tool you installed, then press **Enter**:

| If you installed... | Type this |
|---|---|
| Claude Code | `claude` |
| Antigravity CLI | `agy` |

Give it a few seconds. A colorful welcome screen means it's awake and ready to chat.

> **First time using `agy`?** It'll ask you to sign in with a Google account — either a browser tab pops up, or (in Codespaces) it prints a link to click. Sign in once, then it remembers you.

### Step 3: Ask it something

Type your question in plain English (or 日本語!) and press Enter. Try one of the **Power Prompts** shown on your current level — `ruby quest.rb` prints a few every time.

### Step 4: Go back and forth

You never have to close the chat. Click between your two terminals: chat with your AI tutor in one, edit `adventure.rb` in your code editor, then switch to the other terminal to run `ruby quest.rb check`. Repeat until you level up!

---

## 🔁 How It Works: The Loop

Every level follows the same simple loop:

1. **Run** `ruby quest.rb` — it shows you the story, your task, and the coding concepts you'll need.
2. **Edit** `adventure.rb` — this is *your* game file. You add code to it, one level at a time.
3. **Check** your work with `ruby quest.rb check` — it tells you exactly what's missing, with a friendly hint (never the answer).
4. **Level up!** ✅ Pass the check and you earn XP, a new rank, and a peek at what's next.

You grow **one file** — `adventure.rb` — across all 11 levels. By the end, it's a whole game you built yourself.

### Commands

| Command | What it does |
|---|---|
| `ruby adventure.rb` | Play your game! Run this anytime to try out what you've built |
| `ruby quest.rb` | Show your progress map and the current level's story + task |
| `ruby quest.rb check` | Test your `adventure.rb` against the current level's requirements |
| `ruby quest.rb map` | Show just your progress map (levels done, current, locked) and rank |
| `ruby quest.rb lang` | Switch between English and 日本語 |
| `ruby quest.rb reset` | Start your progress over (your `adventure.rb` code is never touched) |

---

## 🐢 A Note on Pacing

Learning to code is like learning an instrument or a new sport — it takes time!

- **No rush.** You don't have to finish this in one day.
- **One level at a time.** A level a day, or a level a week — both are perfectly fine.
- **Follow your curiosity.** Having fun? Do as many levels as you like!

The most important thing is understanding **why** your code works before moving to the next level. Speed doesn't matter here.

---

## 🎓 The Golden Rule

**Your AI is a tutor, not a builder.**

Don't ask it to "build the whole game" — if you do that, the AI learns, but *you* don't. Your tutor already knows this rule (it's built into `AGENTS.md`/`CLAUDE.md`), and it will gently push back and break things into small steps if you ask for too much at once.

Instead, try **Power Prompts** like these:
- *"I want the player to pick a weapon from a list. How do I do that in Ruby, and what does `gets` actually do?"*
- *"Why did you suggest an `if` statement here instead of something else? What happens if I change it?"*
- *"I got an error I don't understand — can you explain what it means before telling me how to fix it?"*

Every level's story screen also suggests a few power prompts to get you started.

---

## 💡 Troubleshooting

Stuck, or see a scary red error message?

1. **Don't panic.** Errors just mean the computer is confused — they're normal, even for professionals.
2. **Copy the whole error message.**
3. **Ask your AI tutor:** paste the error and ask *"What does this error mean, and what should I look at first?"*
4. Run `ruby quest.rb check` again anytime — its hints are there to help you find the fix yourself.

---

## 🏆 Want to See a Finished Example?

Check out [`adventure_sample.rb`](./adventure_sample.rb) — a completed Level 11 game. Run it with:
```
ruby adventure_sample.rb
```

---

## 🚦 Ready?

Run `ruby quest.rb` and start your adventure!
