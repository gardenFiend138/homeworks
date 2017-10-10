# Was not able to get one test to pass; not sure why it's putting a stone
# in my opponent's cups; see line 45 for start of logic

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    @cups = Array.new(14) { Array.new([]) }
    place_stones
  end

  def place_stones
    @cups.each_with_index do |cup, idx|
      4.times { cup << :stone unless idx == 6 || idx == 13 }
    end
  end

  def valid_move?(start_pos)
    if start_pos < 0 ||
      start_pos > 12 ||
      @cups[start_pos].empty?
      raise "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []

    idx = start_pos
    until stones.empty?
      idx += 1
      if idx > @cups.length - 1
        idx = 0
      end
      # Need to figure out why this case statement wasn't working...
      # case current_player_name
      # when current_player_name == @player1
      #   @cups[idx] << :stone unless idx == 13
      # when current_player_name == @player2
      #   @cups[idx] << :stone unless idx == 6
      # end
      # Same reason that the below wasn't working with stones as an integer;
      # I was decrementing every time, but when idx is 6 and player is 2,
      # I want to NOT do anything. 
      if idx == 6
        @cups[idx] << stones.pop if current_player_name == @player1
      elsif idx == 13
        @cups[idx] << stones.pop if current_player_name == @player2

      else
        @cups[idx] << stones.pop
      end

    end

    render
    next_turn(idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].length == 1
      :switch
    else
    ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    if @cups[0...6].all?(&:empty?) ||
      @cups[7...13].all?(&:empty?)
      return true
    end
    false
  end

  def winner
    case @cups[6].length <=> @cups[13].length
    when -1
      return "#{@player2}"
    when 0
      return :draw
    when 1
      return "#{@player1}"
    end
  end
end
