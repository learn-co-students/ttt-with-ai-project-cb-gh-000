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

  def input_to_index(input, is_index = false)
    is_index ? input : input.to_i - 1
  end

  def position(input, is_index = false)
    @cells[input_to_index(input, is_index)]
  end

  def full?
    @cells.detect { |cell| cell == ' ' }.nil?
  end

  def turn_count
    @cells.select { |cell| cell != ' ' }.size
  end

  def positions_taken? (positions, is_index = false)
    !positions.detect { |position| available?(position, is_index) }
  end

  def available?(position, is_index = false)
    !taken?(position, is_index)
  end

  def taken?(position, is_index = false)
    @cells[input_to_index(position, is_index)] != ' '
  end

  def valid_move?(position, is_index = false)
    index = input_to_index(position, is_index)
    return false if index < 0 || index > 8
    return false if taken?(position, is_index)
    true
  end

  def update(position, player)
    @cells[input_to_index(position)] = player.token
  end

end