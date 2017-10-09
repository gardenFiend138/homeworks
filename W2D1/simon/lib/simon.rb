class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq, :user_guess

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
    @user_guess = []
    @score = 0
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    round_success_message if !game_over
    @sequence_length += 1
  end

  def show_sequence
    add_random_color
    puts seq.join(" ")
    sleep(2)
    system 'clear'
  end

  def require_sequence
    puts "Alright, what were the colors?"
    @user_guess = gets.chomp

    if !correct_guess?(user_guess)
      @game_over = true
    else 
    @score += 1
    end
  end

  def correct_guess?(sequence)
    correct_sequence = seq.join(" ")
    sequence == correct_sequence
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "Correct!"
  end

  def game_over_message
    puts "Wah wah wah...you lose!"
    puts "The correct sequence was: #{seq}"
    puts "Your sequence was: #{user_guess}"
    puts "You made it #{@score} rounds."
  end

  def reset_game
    initialize
  end
end

if $PROGRAM_NAME == __FILE__
  Simon.new.play
end
