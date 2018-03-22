class Players

	class Human < Player

		def initialize(token="X")
			@token = token
		end

		def move(board)
			puts "input from 1-9"
			gets.strip
		end
	end

end
