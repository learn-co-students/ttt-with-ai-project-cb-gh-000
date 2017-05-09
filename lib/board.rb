class Board

  attr_accessor :cells

  def initialize
    reset!
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{ @cells[0] } | #{ @cells[1] } | #{ @cells[2] } "
    puts "-----------"
    puts " #{ @cells[3] } | #{ @cells[4] } | #{ @cells[5] } "
    puts "-----------"
    puts " #{ @cells[6] } | #{ @cells[7] } | #{ @cells[8] } "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def position(input)
    @cells[input_to_index(input)]
  end

  def full?
    @cells.detect { |cell| cell == ' ' }.nil?
  end

  def turn_count
    @cells.select { |cell| cell != ' ' }.size
  end

  def taken?(position)
    @cells[input_to_index(position)] != ' '
  end

  def valid_move?(position)
    index = input_to_index(position)
    return false if index < 0 || index > 8
    return false if taken?(position)
    true
  end

  def update(position, player)
    @cells[input_to_index(position)] = player.token
  end

end