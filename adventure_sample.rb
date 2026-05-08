# adventure_sample.rb
# A finished example for Level 10 of Code Adventure

# --- Game Setup ---
player_name = ""
inventory = ["Potion"]
game_state = { level: 1, health: 100 }

# --- Methods ---
def display_header(text)
  puts "\n" + "=" * 30
  puts text.center(30)
  puts "=" * 30 + "\n"
end

def save_game(name, health, inventory)
  data = "Name: #{name}\nHealth: #{health}\nInventory: #{inventory.join(',')}"
  File.write("save_game.txt", data)
  puts "📝 Game saved to save_game.txt!"
end

# --- Intro ---
display_header("CODE ADVENTURE")
print "Enter your hero name: "
player_name = gets.chomp
puts "Welcome, #{player_name}! Your journey begins."

# --- Main Game Loop ---
loop do
  display_header("MAP")
  puts "1. Explore the Forest 🌲"
  puts "2. Check Backpack 🎒"
  puts "3. Save and Quit 💾"
  print "What do you want to do? "
  choice = gets.chomp

  case choice
  when "1"
    puts "You walk into the dark forest..."
    if rand(1..2) == 1
      puts "👾 A wild Ruby-Monster appears!"
      damage = rand(10..30)
      game_state[:health] -= damage
      puts "It hits you for #{damage} damage! Your health is now #{game_state[:health]}."
      
      if game_state[:health] <= 0
        puts "💀 Oh no! You have fallen in battle. Game Over."
        break
      end
    else
      item = ["Gold Coin", "Shield", "Magic Herb"].sample
      puts "✨ You found a #{item}!"
      inventory << item
    end

  when "2"
    puts "--- Your Backpack ---"
    if inventory.empty?
      puts "It's empty!"
    else
      inventory.each { |item| puts "- #{item}" }
    end
    puts "Total health: #{game_state[:health]}"

  when "3"
    save_game(player_name, game_state[:health], inventory)
    puts "Thanks for playing, #{player_name}! Goodbye."
    break

  else
    puts "❌ I don't understand that command."
  end
end
