
class Game 
  
  attr_accessor :board, :player_1, :player_2
  
  WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2] ]
  
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1 
    @player_2 = player_2 
    @board = board
  end
  
  def current_player
    if board.turn_count % 2 == 0  
      player_1
    else
      player_2
    end
  end
  
  def over?
    board.cells.all? { |cell| cell == "X" || cell == "O" } 
  end
  
  def win 
    WIN_COMBINATIONS.any?{|com| board.cells[com[0]] != " " && board.cells[com[0]] == board.cells[com[1]] && board.cells[com[1]] == board.cells[com[2]]  }
  end
  
  def won?
    if win
      WIN_COMBINATIONS.find{|com| com if board.cells[com[0]] != " " && board.cells[com[0]] == board.cells[com[1]] && board.cells[com[1]] == board.cells[com[2]] }
    else 
      return false 
    end
  end
  
  def draw?
    !win && over?
  end
  
  def winner
    if win
      board.cells[won?[1]]
    else 
      return nil
    end
  end
  
  def turn
    player = current_player
    current_move = player.move(board)
    if !@board.valid_move?(current_move)
      turn 
    else 
      puts "Turn: #{@board.turn_count+1}\n"
      board.display
      board.update(current_move, current_player)
      puts "#{player.token} moved #{current_move}"
      board.display
      puts "\n\n"
    end
  end
  
  def play
    while !draw? && !won?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
  
end




# learn spec/04_game_spec.rb --fail-fast





