
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
    [2, 4, 6]
  ]

  def initialize(pOne = Players::Human.new("X"), pTwo = Players::Human.new("O"), board = Board.new)
    @player_1 = pOne
    @player_2 = pTwo
    @board = board
  end

  def current_player
    count = @board.turn_count
    if(count%2 == 0)
      return player_1
    else
      return player_2
    end
  end

  def won?
    WIN_COMBINATIONS.each do |comb|
      if(@board.cells[comb[0]] == player_1.token && @board.cells[comb[1]] == player_1.token && @board.cells[comb[2]] == player_1.token)
        return comb
      elsif(@board.cells[comb[0]] == player_2.token && @board.cells[comb[1]] == player_2.token && @board.cells[comb[2]] == player_2.token)
        return comb
      end
    end

    return false
  end

  def draw?
    if(!self.won? && board.full?)
      return true
    else
      return false
    end
  end

  def over?
    if draw?
      return true
    elsif won?
      return true
    else
      return false
    end
  end

  def winner
    if won?
      return board.cells[won?[0]]
    else
      return nil
    end
  end

  def turn
    inp = @player_1.move(@board)

    while(!@board.valid_move?(inp))
      inp = player_1.move(@board)
    end
    @board.update(inp, player_1)
    temp = @player_2
    @player_2 = player_1
    @player_1 = temp
  end

  def play
    while !over?
      turn
    end

    if won?
      puts "Congratulations #{self.winner}!"
    else
      puts "Cat's Game!"
    end

  end
end
