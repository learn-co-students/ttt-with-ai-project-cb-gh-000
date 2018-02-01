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

  def turn
    puts "Please enter 1-9:"

    pos = current_player.move(@board)

    if @board.valid_move?(pos)
      @board.update(pos, current_player)
    else
      turn
    end
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    end

    if draw?
      puts "Cat's Game!"
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
