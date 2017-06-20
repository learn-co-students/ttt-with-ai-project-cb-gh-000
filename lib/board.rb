class Board
  attr_accessor :cells

  def initialize
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

  def position(input)
    cells[input.to_i - 1]
  end

  def full?
    cells.all? { |e| e != " " }
  end

  def turn_count
    cells.count { |e| e != " " }
  end

  def taken?(input)
    position(input) != " "
  end

  def valid_move?(input)
    (input.to_i).between?(1, 9) && !taken?(input) ? true : false
  end

  def update(input, player)
    cells[input.to_i - 1] = player.token
  end

  # Below methods are for the AI
  def create_newTemp_board(str, index)
    temp_board = Board.new
    temp_board.cells = ["#{cells[0]}", "#{cells[1]}", "#{cells[2]}",
                        "#{cells[3]}", "#{cells[4]}", "#{cells[5]}",
                        "#{cells[6]}", "#{cells[7]}", "#{cells[8]}"]
    temp_board.cells[index] = str
    temp_board
  end

  def empty_indices
    indices = []
    cells.each_with_index { |cell, i| indices << i if cell == " " }
    indices
  end
end
