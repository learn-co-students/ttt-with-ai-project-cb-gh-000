class Game
  attr_accessor :board, :player_1, :player_2
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2],
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    token = @board.turn_count % 2 == 0 ? "X" : "O"
    @player_1.token == token ? @player_1 : @player_2
  end

  def over?
    won? || draw?
  end

  def won?
    if @board.cells.all? { |x| x == " " }
      false
    elsif WIN_COMBINATIONS.none? { |comb| include_array?(comb) }
      false
    else
      WIN_COMBINATIONS.each { |comb| return comb if include_array?(comb) }
    end
  end

  def draw?
    !won? && full? && WIN_COMBINATIONS.none? { |comb| include_array?(comb) }
  end

  def winner
    won? ? @board.cells[won?[0]] : nil
  end

  def loser
    if winner
      @player_1.token == winner ? @player_2 : @player_1
    else
      nil
    end
  end

  def turn
    pos = current_player.move(@board)

    if @board.valid_move?(pos)
      puts "#{current_player.name}\'s turn: #{current_player.name} moves #{pos}."
      @board.update(pos, current_player)
      puts ""
      @board.display
      puts ""
    else
      turn
    end
  end

  def play
    prefix_1 = @player_1.class == Players::Computer ? "Robot " : ""
    prefix_2 = @player_2.class == Players::Computer ? "Robot " : ""
    3.times { puts "" }
    puts "#{prefix_1}#{@player_1.name} vs #{prefix_2}#{@player_2.name}, Start!"
    puts ""
    @board.display
    puts ""

    until over?
      turn
    end

    if won?
      3.times { puts "" }
      puts "Congratulations #{winner}!"
      puts ""
      puts "#{@player_1.token == winner ? @player_1.name : @player_2.name} defeats #{loser.name} in the end."
      return "over"
    end

    if draw?
      puts "Cat's Game!"
      return "over"
    end
  end

  def full?
    @board.cells.none? { |x| x == "" || x == " " || x == nil }
  end

  def include_array?(comb)
    comb.all? { |x| @board.position_taken?(x) } &&
    @board.cells[comb[0]] == @board.cells[comb[1]] &&
    @board.cells[comb[1]] == @board.cells[comb[2]]
  end

  def move(index, current_player)
    @board.cells[index] = current_player
  end
end
