class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  def initialize(p1 = Players::Human.new("X"), p2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = p1
    @player_2 = p2
  end

  def current_player
    if self.board.turn_count % 2 == 0
      @player_1
    else
      @player_2
    end
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      if @board.cells[combination[0]] == "X" && @board.cells[combination[1]] == "X" && @board.cells[combination[2]] == "X"
        return combination
      elsif @board.cells[combination[0]] == "O" && @board.cells[combination[1]] == "O" && @board.cells[combination[2]] == "O"
        return combination
      end
    end
    nil
  end

  def draw?
    @board.full? && self.won? == nil
  end

  def over?
    self.draw? || self.won?
  end

  def winner
    if self.won? != nil
      @board.cells[self.won?[0]]
    end
  end

  def turn
    player = current_player
    current_move = player.move(@board)
    if !@board.valid_move?(current_move)
      puts "Your move was invalid!"
      turn
    else
      puts "Turn: #{@board.turn_count+1}\n"
      @board.update(current_move, player)
      @board.display
      puts "\n\n"
    end
  end

  def play
    puts "Welcome to Tic-Tac-Toe"
    @board.display
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
