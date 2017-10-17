class Board
  attr_accessor :cells

  def initialize
    @cells = Array.new(9, " ")
  end

  def reset!
    @cells.clear
    @cells = Array.new(9, " ")
  end

  def display
    i = 0
    while i < 9
      puts " #{@cells[i]} | #{@cells[i + 1]} | #{@cells[i + 2]} "
      puts "-----------" if i < 6
      i += 3
    end
  end

  def position(input)
    @cells[input.to_i - 1]
  end

  def full?
    !@cells.include?(" ")
  end

  def turn_count
    9 - @cells.select{|i| i == " "}.count
  end

  def taken?(input)
    position(input) != " "
  end

  def valid_move?(input)
    (1..9).cover?(input.to_i) && !taken?(input)
  end

  def update(input, player)
    @cells[input.to_i - 1] = player.token
  end

end
