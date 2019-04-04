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
 		[6, 4, 2]
 	]

 	def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
 		@board = board
 		@player_1 = player_1
 		@player_2 = player_2
 	end


 	def current_player
 		turns = board.turn_count

 		if turns % 2 == 0
 			player_1
 		else
 			player_2
 		end
 	end
 	def over?
 		won? || draw?
 	end

 	def won?
 		WIN_COMBINATIONS.detect do |combo|
 			board.cells[combo[0]] == @board.cells[combo[1]] &&
 			board.cells[combo[1]] == board.cells[combo[2]] &&
 			board.taken?(combo[0] + 1)
 		end
 	end

 	def draw?
 		!won? && board.full?
	end
 	def winner
 		if winCombo = won?
 			@winner = @board.cells[winCombo[0]]
 		end
 	end

 	def turn
 		player = current_player
 		move = player.move(board)
 		if !@board.valid_move?(move)
 			turn
 		else
 			@board.update(move, player)
 			@board.display
 	end
 	end

 	def play
 		while !over?
 			turn
 		end
 		if won?
 			puts "Congratulations #{winner}!"
 		else
 			puts "Cat's Game!"
 		end
 	end
 end
