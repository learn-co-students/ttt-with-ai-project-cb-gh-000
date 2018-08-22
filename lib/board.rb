class Board
  attr_accessor :cells

  def initialize
    @cells = Array.new(9, ' ')
  end

  def reset!
    @cells = Array.new(9, ' ')
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts '-----------'
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts '-----------'
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(spot)
    @cells[spot.to_i - 1]
  end

  def full?
    @cells.each_with_index do |_space, index|
      return FALSE unless taken?(index)
    end
    TRUE
  end

  def turn_count
    @cells.count do |token|
      token == 'X' || token == 'O'
    end
  end

  def taken?(index)
    !(position(index).nil? || position(index) == ' ')
  end

  def valid_move?(index)
    index.to_i.between?(1, 9) && !taken?(index)
  end

  def update(index, player)
    @cells[index.to_i - 1] = player.token
  end

end
