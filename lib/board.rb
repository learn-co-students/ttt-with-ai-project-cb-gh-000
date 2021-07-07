class Board

  attr_accessor :cells

  def initialize
    @cells = Array.new(9, " ")
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(input)
    self.cells[input.to_i - 1]
  end

  def full?
    !@cells.include?(" ")
  end

  def turn_count
    turn = 0
    @cells.each {|cell| turn += 1 if cell == "X" || cell == "O"}
    turn
  end

  def taken?(index)
    self.position(index.to_i) == "X" || self.position(index.to_i) == "O"
  end

  def valid_move?(input)
    input.to_i >= 1 && input.to_i <= 9 && !self.taken?(input)
  end

  def update(index, player)
    if self.valid_move?(index)
      @cells[index.to_i-1] = player.token
    end
  end
end
