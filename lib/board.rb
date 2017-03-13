class Board

  attr_accessor :cells

  def initialize
    @cells = []
    self.reset!
  end

  def reset!
    self.cells.clear
    self.cells = Array.new(9, " ")
  end

  def display
    puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
    puts "-----------"
    puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
    puts "-----------"
    puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
  end

  def position(human_position)
    self.cells[human_position.to_i - 1]
  end

  def full?
    !self.cells.include?(" ")
  end

  def turn_count
    self.cells.count{ |cell| cell != " " }
  end

  def taken?(human_position)
    self.position(human_position) != " "
  end

  def valid_move?(human_position)
    human_position.to_i.between?(1, 9) && !self.taken?(human_position)
  end

  def update(human_position, player)
    self.cells[human_position.to_i - 1] = player.token
  end

  def free_cells
    self.cells.each_index.select{ |i| self.cells[i] == " " }
  end

end
