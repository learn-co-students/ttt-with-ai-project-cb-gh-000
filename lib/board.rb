require 'pry'
class Board

  attr_accessor :cells

  def initialize
    @cells = Array.new(9, " ")
  end

  def reset!
    self.cells = Array.new(9, " ")
  end

  def display
    puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
    puts "-----------"
    puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
    puts "-----------"
    puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
    puts "\n"
  end

  def input_to_index(user_input)
    if user_input.is_a?(String)
      int_input = user_input.to_i
      index = int_input - 1
    else
      index = user_input
    end
  end

  def position(user_input)
    index = self.input_to_index(user_input)
    self.cells[index]
  end

  def update(user_input, player)
    if self.valid_move?(user_input)
      index = self.input_to_index(user_input)
      self.cells[index] = player.token
    end
  end

  def full?
    self.cells.all? do |cell|
      cell == "X" || cell == "O"
    end
  end

  def turn_count
    count = 0
    self.cells.each do |cell|
      if cell == "X" || cell == "O"
        count += 1
      end
    end
    count
  end

  def taken?(user_input)
    self.position(user_input) == "X" ||
    self.position(user_input) == "O"
  end

  def valid_position?(index)
    index.between?(0, self.cells.size - 1)
  end

  def valid_move?(user_input)
    index = self.input_to_index(user_input)
    self.valid_position?(index) && !self.taken?(user_input)
  end

end
