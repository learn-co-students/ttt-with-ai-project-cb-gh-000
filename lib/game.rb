class Game

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]
  attr_accessor :player_1, :player_2, :board
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    @board.turn_count % 2 == 0 ? @player_1 : @player_2
  end

  def won?
    winningCombination = []
    WIN_COMBINATIONS.each do |win_combination|
      if @board.cells[win_combination[0]] == "X" && @board.cells[win_combination[1]] == "X" && @board.cells[win_combination[2]] == "X"
        winningCombination = win_combination
      elsif @board.cells[win_combination[0]] == "O" && @board.cells[win_combination[1]] == "O" && @board.cells[win_combination[2]] == "O"
        winningCombination = win_combination
      else
        false
      end
    end
    winningCombination.empty? ? false : winningCombination
  end

  def draw?
    if @board.full? && !won?
      true
    else
      false
    end
  end

  def over?
    if draw? || won?
      true
    else
      false
    end
  end

  def winner
    won? ? @board.cells[won?[0]] : nil
  end

  def turn
    input = current_player.move(@board)
    if @board.valid_move?(input)
      @board.update(input, current_player)
    else
      puts "Wrong input. Try Agian!"
      current_player.move(@board)
    end
  end

  def play
    while !over?
      turn
      @board.display
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
