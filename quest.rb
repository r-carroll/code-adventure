#!/usr/bin/env ruby
# frozen_string_literal: false
#
# quest.rb — the Code Adventure tutorial engine.
# Run it with no arguments to see your quest, or `ruby quest.rb check` to
# test your work. This file is styled like a tiny text adventure itself!

require "yaml"
require "open3"
require "timeout"
require "rbconfig"

# ---------------------------------------------------------------------------
# All player-facing text lives here, in English and Japanese side by side.
# ---------------------------------------------------------------------------
UI = {
  en: {
    lang_prompt: "🌐 Choose your language / 言語を選んでください:\n  1. English\n  2. 日本語",
    lang_switched: "🌐 Language set to English!",
    need_start: "👋 You haven't started your quest yet! Run `ruby quest.rb` to begin.",
    save_corrupt: "😵 Your save file looks damaged. Run `ruby quest.rb reset` to start fresh (your adventure.rb code is totally safe).",
    save_corrupt_recovered: "😵 Your old save file looked damaged, so I backed it up and we're starting a fresh quest. Don't worry, adventure.rb was not touched!",
    reset_nothing: "🤷 There's no save file to reset — you're already at square one!",
    reset_confirm: "⚠️  This will erase your quest progress (not your adventure.rb code). Continue? (y/n)",
    reset_done: "🗑️  Progress reset! Run `ruby quest.rb` to start your quest again.",
    reset_cancelled: "👍 Okay, nothing was reset.",
    level_missing: "📄 Hmm, I can't find the data for Level %<num>d. Ask an adult to check the quest/levels folder!",
    checking_banner: "🔍 Checking Level %<num>d...",
    task_header: "== YOUR TASK ==",
    concepts_header: "📚 CONCEPTS:",
    power_prompts_header: "💬 Ask your AI tutor (open a second terminal, then type `claude` or `agy`):",
    reminder: "✏️  Edit adventure.rb, then run: ruby quest.rb check",
    xp_gained: "✨ +%<xp>d XP earned! (Total: %<total>d XP)",
    rank_up: "🌟 New rank unlocked: %<rank>s!",
    graduation_message: "🎓 You have completed every level and written your own Ruby text adventure from scratch. That is a HUGE achievement. Go show adventure.rb to a friend or family member — you earned it!",
    tease_next: "👉 Next up: Level %<num>d - %<title>s",
    hint_intro: "❌ Not quite there yet...",
    ask_tutor: "💡 Stuck? Ask your AI tutor about it — that's what it's for!",
    map_header: "🗺️  QUEST MAP",
    map_xp: "   XP: %<xp>d",
    map_rank: "   Rank: %<rank>s",
    usage_help: "❓ Unknown command: %<cmd>s\n\nAvailable commands:\n  ruby quest.rb          show your quest map & current level\n  ruby quest.rb check    test your adventure.rb against the current level\n  ruby quest.rb map      show the quest map only\n  ruby quest.rb lang     switch language\n  ruby quest.rb reset    erase progress and start over",
    welcome_new: "🎉 Welcome, adventurer! Your quest begins now.",
    adventure_created: "📜 I created adventure.rb for you — that's where your game lives!",
    graduated_recap: "🎓 You've already graduated as a Ruby Master! Run `ruby quest.rb map` to admire your finished quest, or keep polishing adventure.rb for fun.",
    level_label: "Level %<num>d",
  }.freeze,
  ja: {
    lang_prompt: "🌐 Choose your language / 言語を選んでください:\n  1. English\n  2. 日本語",
    lang_switched: "🌐 言語を日本語に設定しました！",
    need_start: "👋 まだクエストを始めていないみたいです！ `ruby quest.rb` を実行して冒険を始めよう。",
    save_corrupt: "😵 セーブファイルが壊れているようです。 `ruby quest.rb reset` を実行すると新しく始められます（adventure.rbのコードは絶対に消えないので安心してね）。",
    save_corrupt_recovered: "😵 古いセーブファイルが壊れていたので、バックアップを取って新しいクエストを始めます。adventure.rbのコードには一切さわっていないので安心してね！",
    reset_nothing: "🤷 リセットするセーブデータがありません。すでにスタート地点にいますよ！",
    reset_confirm: "⚠️  クエストの進み具合を消去します（adventure.rbのコードは消えません）。よろしいですか？ (y/n)",
    reset_done: "🗑️  進み具合をリセットしました！ もう一度 `ruby quest.rb` を実行してクエストを始めよう。",
    reset_cancelled: "👍 わかりました、何も変更していません。",
    level_missing: "📄 あれ、レベル%<num>dのデータが見つかりません。大人の人に quest/levels フォルダを確認してもらってね！",
    checking_banner: "🔍 レベル%<num>dをチェック中...",
    task_header: "== 今回のタスク ==",
    concepts_header: "📚 学ぶポイント：",
    power_prompts_header: "💬 AI先生に聞いてみよう（別のターミナルを開いて `claude` か `agy` と入力してね）：",
    reminder: "✏️  adventure.rbを編集したら、こう実行してね： ruby quest.rb check",
    xp_gained: "✨ +%<xp>d XP を獲得！（合計：%<total>d XP）",
    rank_up: "🌟 新しいランクに昇格：%<rank>s！",
    graduation_message: "🎓 全レベルをクリアして、自分だけのRubyテキストアドベンチャーを完成させました！これは本当にすごいことです。adventure.rbを家族や友達に見せてあげよう。よくがんばったね！",
    tease_next: "👉 次のクエスト：レベル%<num>d - %<title>s",
    hint_intro: "❌ おしい、まだクリアじゃないよ...",
    ask_tutor: "💡 困ったときはAI先生に聞いてみよう。それが先生の仕事だよ！",
    map_header: "🗺️  クエストマップ",
    map_xp: "   XP：%<xp>d",
    map_rank: "   ランク：%<rank>s",
    usage_help: "❓ わからないコマンドです： %<cmd>s\n\n使えるコマンド：\n  ruby quest.rb          クエストマップと現在のレベルを表示\n  ruby quest.rb check    adventure.rbを現在のレベルでチェック\n  ruby quest.rb map      クエストマップだけを表示\n  ruby quest.rb lang     言語を切り替える\n  ruby quest.rb reset    進み具合を消してやり直す",
    welcome_new: "🎉 ようこそ、冒険者！ クエストが今始まります。",
    adventure_created: "📜 あなたのために adventure.rb を作りました。ここが君のゲームの家だよ！",
    graduated_recap: "🎓 あなたはもうルビーマスターとして卒業しています！ `ruby quest.rb map` で自分の完成したクエストを眺めたり、adventure.rbをさらに磨いたりしてみてね。",
    level_label: "レベル%<num>d",
  }.freeze,
}.freeze

RANKS = [
  { min: 0, max: 1, en: "Apprentice", ja: "見習い" },
  { min: 2, max: 3, en: "Code Squire", ja: "コード従者" },
  { min: 4, max: 5, en: "Rune Coder", ja: "ルーンコーダー" },
  { min: 6, max: 7, en: "Logic Knight", ja: "ロジック騎士" },
  { min: 8, max: 9, en: "World Builder", ja: "ワールドビルダー" },
  { min: 10, max: 10, en: "Ruby Master", ja: "ルビーマスター" },
].freeze

TITLE_BANNER = <<~ART
#{ "\e" }[31m
        __________________
      .'_/_/_/_|__\\_\\_\\_\\_'.
     /______________________\\
     \\    |    |  |    |    /
      \\   |    |  |    |   /
       \\  |    |  |    |  /
        \\ |    |  |    | /
         \\|____|__|____|/
          \\    |  |    /
           \\   |  |   /
            \\  |  |  /
             \\ |  | /
              \\|__|/
               \\  /
                \\/
#{ "\e" }[0m
#{ "\e" }[36m
   _____ ____  _____  ______ 
  / ____/ __ \\|  __ \\|  ____|
 | |   | |  | | |  | | |__   
 | |   | |  | | |  | |  __|  
 | |___| |__| | |__| | |____ 
  \\_____\\____/|_____/|______|

     /\\   |  __ \\ \\    / /  ____| \\ | |__   __| |  | |  __ \\|  ____|
    /  \\  | |  | \\ \\  / /| |__  |  \\| |   | |  | |  | | |__) | |__   
   / /\\ \\ | |  | |\\ \\/ / |  __| | . ` |   | |  | |  | |  _  /|  __|  
  / ____ \\| |__| | \\  /  | |____| |\\  |   | |  | |__| | | \\ \\| |____ 
 /_/    \\_\\_____/   \\/   |______|_| \\_|   |_|   \\____/|_|  \\_\\______|
#{ "\e" }[0m
ART

CELEBRATION_ART = <<~ART
     🎉✨  LEVEL CLEARED!  ✨🎉
        \\o/    \\o/    \\o/
         |      |      |
        / \\    / \\    / \\
ART

TROPHY_ART = <<~ART
          _.-""""""-._
         /  🏆🏆🏆🏆  \\
        |______________|
              |  |
            __|  |__
           '--------'
     🏆   RUBY MASTER!   🏆
ART

# ---------------------------------------------------------------------------
# The engine itself.
# ---------------------------------------------------------------------------
class QuestEngine
  LEVEL_COUNT = 10
  ADVENTURE_FILE = "adventure.rb"
  SAVE_FILE = ".quest_save.yml"
  LEVELS_DIR = File.join(__dir__, "quest", "levels")
  RUN_TIMEOUT = 10
  QUIT_PADDING = ("quit\n" * 30)

  def initialize
    @lang = :en
  end

  def run(args)
    case args.first
    when nil then default_flow
    when "check" then cmd_check
    when "map" then cmd_map
    when "lang" then cmd_lang
    when "reset" then cmd_reset
    else cmd_usage(args.first)
    end
  end

  # -- top level flows ------------------------------------------------------

  def default_flow
    save = load_save
    case save
    when :missing
      save = first_run_setup
    when :corrupt
      backup_corrupt_save
      puts bi(:save_corrupt_recovered)
      save = first_run_setup
    else
      puts TITLE_BANNER
      ensure_adventure_file
    end
    print_map(save)
    show_level_briefing(save)
  end

  def cmd_check
    save = load_save
    return puts(bi(:need_start)) if save == :missing
    return puts(bi(:save_corrupt)) if save == :corrupt

    if graduated?(save)
      puts t(:graduated_recap)
      return
    end

    level = load_level(save["level"])
    return puts(t(:level_missing, num: save["level"])) unless level

    puts t(:checking_banner, num: save["level"])
    level[:checks].each do |check|
      unless run_check(check)
        print_hint_failure(check)
        return
      end
    end
    advance_and_celebrate(save, level)
  end

  def cmd_map
    save = load_save
    return puts(bi(:need_start)) if save == :missing
    return puts(bi(:save_corrupt)) if save == :corrupt

    print_map(save)
  end

  def cmd_lang
    save = load_save
    return puts(bi(:need_start)) if save == :missing
    return puts(bi(:save_corrupt)) if save == :corrupt

    @lang = prompt_language
    save["language"] = @lang.to_s
    write_save(save)
    puts t(:lang_switched)
  end

  def cmd_reset
    unless File.exist?(SAVE_FILE)
      puts bi(:reset_nothing)
      return
    end
    puts bi(:reset_confirm)
    print "> "
    answer = $stdin.gets.to_s.strip.downcase
    if %w[y yes はい].include?(answer)
      File.delete(SAVE_FILE)
      puts bi(:reset_done)
    else
      puts bi(:reset_cancelled)
    end
  end

  def cmd_usage(cmd)
    puts bi(:usage_help, cmd: cmd.to_s)
  end

  private

  # -- save handling ---------------------------------------------------------

  # Returns a save Hash on success, or :missing / :corrupt as a sentinel.
  def load_save
    return :missing unless File.exist?(SAVE_FILE)

    data = YAML.safe_load(File.read(SAVE_FILE))
    raise "not a hash" unless data.is_a?(Hash)
    raise "missing keys" unless %w[language level xp].all? { |k| data.key?(k) }
    raise "bad language" unless %w[en ja].include?(data["language"])
    raise "bad level" unless data["level"].is_a?(Integer)
    raise "bad xp" unless data["xp"].is_a?(Integer)

    @lang = data["language"].to_sym
    data
  rescue StandardError
    :corrupt
  end

  def write_save(save)
    File.write(SAVE_FILE, YAML.dump(save))
  rescue StandardError
    # If we can't persist, the student can keep playing this session; a
    # stack trace would be far scarier than a quiet failure here.
    nil
  end

  def backup_corrupt_save
    File.rename(SAVE_FILE, "#{SAVE_FILE}.bak")
  rescue StandardError
    nil
  end

  def graduated?(save)
    save["level"] > LEVEL_COUNT
  end

  # -- first run ---------------------------------------------------------

  def first_run_setup
    puts TITLE_BANNER
    @lang = prompt_language
    save = { "language" => @lang.to_s, "level" => 1, "xp" => 0 }
    write_save(save)
    ensure_adventure_file
    puts
    puts t(:welcome_new)
    save
  end

  def prompt_language
    puts UI[:en][:lang_prompt]
    print "> "
    answer = $stdin.gets.to_s.strip
    answer == "2" ? :ja : :en
  end

  def ensure_adventure_file
    return if File.exist?(ADVENTURE_FILE)

    File.write(ADVENTURE_FILE, adventure_header)
    puts t(:adventure_created)
  end

  def adventure_header
    <<~RUBY
      # Welcome to YOUR adventure! ✨ / ようこそ、あなたの冒険へ！✨
      # This file is your text adventure game. Every quest level, you'll add
      # a little more to it, right here.
      # このファイルがあなたの冒険ゲームです。レベルが進むたびに、ここへ
      # 少しずつコードを追加していきます。
      # To play your game, run: `ruby adventure.rb`
      # ゲームを遊ぶには： `ruby adventure.rb` を実行してね。
      #
      # Run `ruby quest.rb` to see your quest, `ruby quest.rb check` to test it.
      # `ruby quest.rb` でクエスト画面、`ruby quest.rb check` でチェックができます。

    RUBY
  end

  # -- map & level briefing -------------------------------------------------

  def print_map(save)
    rank = rank_for(save["level"] - 1)
    puts
    puts t(:map_header)
    puts t(:map_xp, xp: save["xp"])
    puts t(:map_rank, rank: rank[@lang])
    puts
    (1..LEVEL_COUNT).each do |n|
      icon = level_icon(save, n)
      level = load_level(n)
      title = level ? level[:title][@lang] : "???"
      puts "  #{icon}  #{n}. #{title}"
    end
    puts
  end

  def level_icon(save, n)
    if save["level"] > n then "✅"
    elsif save["level"] == n then "👉"
    else "🔒"
    end
  end

  def show_level_briefing(save)
    if graduated?(save)
      puts t(:graduated_recap)
      return
    end

    level = load_level(save["level"])
    return puts(t(:level_missing, num: save["level"])) unless level

    puts "─" * 44
    puts "#{t(:level_label, num: level[:id])}: #{level[:title][@lang]}"
    puts "─" * 44
    puts level[:story][@lang]
    puts
    puts t(:task_header)
    level[:task][@lang].each_with_index { |line, i| puts "  #{i + 1}. #{line}" }
    puts
    puts t(:concepts_header)
    puts level[:concepts][@lang]
    puts
    puts t(:power_prompts_header)
    level[:power_prompts][@lang].each { |p| puts "  - #{p}" }
    puts
    puts t(:reminder)
  end

  def rank_for(completed_count)
    completed = completed_count.clamp(0, LEVEL_COUNT)
    RANKS.find { |r| completed.between?(r[:min], r[:max]) }
  end

  # -- checking & celebrating -------------------------------------------------

  def advance_and_celebrate(save, level)
    old_rank = rank_for(save["level"] - 1)
    save["xp"] += level[:xp]
    save["level"] += 1
    new_rank = rank_for(save["level"] - 1)
    write_save(save)

    puts
    puts CELEBRATION_ART
    puts t(:xp_gained, xp: level[:xp], total: save["xp"])
    puts t(:rank_up, rank: new_rank[@lang]) if new_rank != old_rank

    if graduated?(save)
      puts
      puts TROPHY_ART
      puts t(:graduation_message)
    else
      next_level = load_level(save["level"])
      next_title = next_level ? next_level[:title][@lang] : "???"
      puts t(:tease_next, num: save["level"], title: next_title)
    end
  end

  def print_hint_failure(check)
    puts
    puts t(:hint_intro)
    puts "   #{check[:hint][@lang]}"
    puts
    puts t(:ask_tutor)
  end

  def load_level(n)
    path = File.join(LEVELS_DIR, format("level_%02d.yml", n))
    return nil unless File.exist?(path)

    data = YAML.safe_load(File.read(path), symbolize_names: true)
    return nil unless data.is_a?(Hash) && data[:checks].is_a?(Array)

    data
  rescue StandardError
    nil
  end

  def run_check(check)
    case check[:type]
    when "file_exists" then check_file_exists
    when "source" then check_source(check)
    when "run" then check_run(check)
    else false
    end
  rescue StandardError
    false
  end

  def check_file_exists
    File.exist?(ADVENTURE_FILE) && !File.zero?(ADVENTURE_FILE)
  end

  def check_source(check)
    return false unless File.exist?(ADVENTURE_FILE)

    source = File.read(ADVENTURE_FILE)
    matched = Regexp.new(check[:pattern]).match?(source)
    check[:absent] ? !matched : matched
  end

  def check_run(check)
    output = capture_program_output(check[:stdin].to_s)
    expects = Array(check[:expect]).map { |p| Regexp.new(p, Regexp::IGNORECASE) }
    forbids = Array(check[:forbid]).map { |p| Regexp.new(p, Regexp::IGNORECASE) }
    expects.all? { |r| r.match?(output) } && forbids.none? { |r| r.match?(output) }
  end

  # Runs `ruby adventure.rb`, feeding it the check's stdin plus 30 extra
  # "quit\n" lines so any quit-loop the student wrote reaches EOF cleanly.
  # Captures combined stdout+stderr and never lets a hang or crash escape.
  def capture_program_output(stdin_data)
    return "" unless File.exist?(ADVENTURE_FILE)

    full_input = stdin_data + QUIT_PADDING
    output = +""
    path = File.expand_path(ADVENTURE_FILE)
    # Force unbuffered output in the child. adventure.rb's stdout is a pipe,
    # not a TTY, so Ruby fully-buffers it by default — without this, a
    # student's infinite loop would lose every bit of output on timeout.
    # The path is baked into the script (not passed as an ARGV arg) — if it
    # were in ARGV, the student's own bare `gets` calls would be hijacked by
    # ARGF into reading from adventure.rb's source instead of our stdin!
    sync_script = "STDOUT.sync = true; STDERR.sync = true; load(#{path.inspect})"

    Open3.popen2e(RbConfig.ruby, "-e", sync_script) do |stdin, out, wait_thr|
      writer = Thread.new do
        stdin.write(full_input)
      rescue StandardError
        nil
      ensure
        stdin.close rescue nil
      end

      reader = Thread.new do
        out.each_line { |line| output << line }
      rescue StandardError
        nil
      end

      begin
        Timeout.timeout(RUN_TIMEOUT) { wait_thr.value }
      rescue Timeout::Error
        kill_process(wait_thr.pid)
      end

      writer.join(1)
      reader.join(2)
    end

    output
  rescue StandardError => e
    output.to_s + "\n[quest.rb could not run adventure.rb: #{e.message}]"
  end

  def kill_process(pid)
    Process.kill("KILL", pid)
  rescue StandardError
    nil
  end

  # -- text helpers -----------------------------------------------------------

  def t(key, **vars)
    template = UI.dig(@lang, key) || UI[:en][key]
    vars.empty? ? template : format(template, **vars)
  end

  # Bilingual message for moments before we know (or trust) the language.
  def bi(key, **vars)
    %i[en ja].map do |l|
      template = UI[l][key]
      vars.empty? ? template : format(template, **vars)
    end.join("\n")
  end
end

QuestEngine.new.run(ARGV) if $PROGRAM_NAME == __FILE__
