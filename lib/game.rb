class Game
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

  attr_accessor :board, :player_1, :player_2

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    @board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def over?
    @board.full? || self.won? || self.draw?
  end

  def won?
    WIN_COMBINATIONS.each do |arr|
      return arr if @board.cells[arr[0]] != " " && @board.cells[arr[0]] == @board.cells[arr[1]] && @board.cells[arr[1]] == @board.cells[arr[2]]
    end
    false
  end

  def draw?
    !self.won? && @board.full? 
  end

  def winner
    result = self.won?
    result ? @board.position(result[0] + 1) : nil
  end

  def turn
    move = self.current_player.move(@board.cells)
    @board.valid_move?(move) ? @board.update(move, self.current_player) : self.turn
  end

  def play
    until self.over?
      self.turn
    end
    puts self.winner ? "Congratulations #{self.winner}!" : "Cat's Game!"
  end
end