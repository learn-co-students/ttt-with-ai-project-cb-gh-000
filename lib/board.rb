require "pry"

class Board
  attr_accessor :cells

  def initialize
    @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def reset!
    @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(index)
    @cells[index.to_i - 1]
  end

  def full?
    self.turn_count == 9
  end

  def turn_count
    filled_cells = @cells.select{|cell| cell != " "}
    filled_cells.size
  end

  def taken?(cell)
    @cells[cell.to_i - 1] != " "
  end

  def valid_move?(input)
    index = input.to_i
    index.between?(1,9) && taken?(index) == false
  end

  def update(index, player)
    @cells[index.to_i - 1] = player.token
  end

end
