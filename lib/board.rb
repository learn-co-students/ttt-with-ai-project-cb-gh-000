class Board
	attr_accessor :cells
	def initialize
		@cells = Array.new(9, " ")
	end

	def cells
		@cells
	end

	def reset!
		@cells = Array.new(9, " ")
	end

	def display
		line = "-----------"
		puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
		puts line
		puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
		puts line
		puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
	end

	def position(position)
		@cells[position.to_i - 1]
	end

	def full?
		@cells.none? { |x| x == "" || x == " " || x == nil }
	end

	def turn_count
		@cells.count {|x| x != " "}
	end

	def taken?(position)
		@cells[position.to_i - 1] == " " ? false : true
	end

	def valid_move?(position)
		(1..9).include?(position.to_i) && !taken?(position)
	end

	def update(position, player)
		@cells[position.to_i - 1] = player.token
	end

end
