class Game

  WIN_COMBINATIONS = [
    [0,1,2],[3,4,5],[6,7,8],
    [0,3,6],[1,4,7],
    [2,5,8],[0,4,8],[6,4,2]
  ]

  attr_accessor :board,:player_1,:player_2

  def initialize player_1 = nil, player_2 = nil, init_board = nil
    @board = init_board || Board.new
    @player_1 = player_1 || Players::Human.new("X")
    @player_2 = player_2 || Players::Computer.new("O")
    @winner = nil
  end

  def current_player
      turns_made = @board.turn_count
      turns_made % 2 == 0 ? @player_1 : @player_2
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      x_wins = win_combination.all? do |index|
        board.cells[index] == "X"
      end
      if x_wins
        @winner = @player_1
        return win_combination
      end
      o_wins = win_combination.all? do |index|
        board.cells[index] == "O"
      end
      if o_wins
        @winner = @player_2
        return win_combination
      end
    end
    return false
  end

  def draw?
    !won? && @board.full?
  end

  def over?
    draw? || won?
  end

  def winner
    return nil unless won?
    @winner.token
  end

  def turn
    puts "Please enter 1-9:"
    index = current_player.move @board
    if @board.valid_move?(index)
      @board.update(index,current_player)
      @board.display
    else
      turn
    end
  end

  def play
    until self.over?
      turn
    end
    if @winner
      puts "Congratulations #{@winner.token}!"
    else
      puts "Cat's Game!"
    end
  end

end
