class Game
  attr_accessor :board, :player_1, :player_2

  def initialize(player_1 = Players::Human.new('X'), player_2 = Players::Human.new('O'), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def turn
    player = current_player
    loop do
      @board.display
      move = current_player.move(@board)
      if @board.valid_move?(move)
        @board.update(move, current_player)
        break
      else
        puts "BAD MOVE"
      end
    end
  end

  def play
    while !over?
      turn
    end
    if !won?
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
      @board.display
    end

  end

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [6, 4, 2],
      [0, 4, 8]
  ].freeze

  def won?
    WIN_COMBINATIONS.each do |combo|
      next unless @board.cells[combo[0]] == @board.cells[combo[1]] && @board.cells[combo[1]] == @board.cells[combo[2]]
      next unless combo.all? do |index|
        @board.taken?(index + 1)
      end
      return combo
      break
    end
    false
  end

  def draw?
    @board.full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    winIndex = won?
    return nil if winIndex == false
    winChar = @board.cells[winIndex[0]]
    return winChar if winChar == 'X' || winChar == 'O'
  end

  def current_player
    @board.turn_count.even? ? @player_1 : @player_2
  end
end
