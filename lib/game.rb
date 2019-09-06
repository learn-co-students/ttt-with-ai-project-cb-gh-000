class Game
  attr_accessor :player_1, :player_2, :board
  
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]
  
  def initialize(player_1 = Players::Human.new('X'), player_2 = Players::Human.new('O'), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end
  
  def turn
    player = current_player
    current_move = player.move(@board)
    if !@board.valid_move?(current_move)
      turn
    else
      puts "Turn: #{@board.turn_count+1}\n"
      @board.display
      @board.update(current_move, player)
      puts "#{player.token} moved #{current_move}"
      @board.display
      puts "\n\n"
    end
  end
  
  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
  
  def turn_count
    @board.turn_count
  end
  
  def current_player
    turn_count % 2 == 0 ? player_1 : player_2
  end
  
  def won?
    WIN_COMBINATIONS.each do |combination|
      if combination.all? { |index| @board.position(index+1) == "X" } || combination.all? { |index| @board.position(index+1) == "O" }
        return combination
      end
    end
    return false
  end
  
  def draw?
    !won? && @board.full?
  end
  
  def over?
    won? || draw?
  end
  
  def winner
    if winning_combo = won?
      return @board.cells[winning_combo.first]
    end
  end
end