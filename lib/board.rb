class Board
	attr_accessor :cells

	def initialize()
		reset!
	end

	def reset!
		@cells = Array.new(9, " ")
	end

	def display
		puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
		puts "-----------"
		puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
		puts "-----------"
		puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
	end

	def position(posIn)
		cells[posIn.to_i - 1]
	end

	def update(posIn, playerObj)
		if valid_move?(posIn)
			cells[posIn.to_i - 1] = playerObj.token
		end
	end

	def turn_count
		cells.count { |token|
			token == "X" || token == "O"
		}
	end

	def full?
		!cells.include?(" ")
	end

	def taken?(posIn)
		!(position(posIn) == " " || position(posIn) == "") 
	end

	def valid_move?(posIn)
		posIn.to_i.between?(1,9) && !taken?(posIn)
	end

end
