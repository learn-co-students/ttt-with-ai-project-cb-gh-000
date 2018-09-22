class Board

  attr_accessor :cells

  def initialize
    reset!
  end

  def reset!
    @cells = []
    @cells = Array.new(9, ' ')
  end

  def display
    print " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} \n-----------\n #{@cells[3]} | #{@cells[4]} | #{@cells[5]} \n-----------\n #{@cells[6]} | #{@cells[7]} | #{@cells[8]} \n"
  end

  def position(target)
    indexed_target = target.to_i - 1
    @cells[indexed_target]
  end

  def full? # return true if board is full
    # board is full when no cell is blank
    !@cells.include?(' ')
  end

  def turn_count
    @cells.count { |token| token == "X" || token == "O"}
  end

  def taken?(position)
    indexed_position = position.to_i - 1
    @cells[indexed_position] == 'X' || @cells[indexed_position] == 'O'
  end

  def valid_move?(position)
    position.to_i.between?(1,9) && !taken?(position)
  end

  def update(position, player)
    indexed_position = position.to_i - 1
    @cells[indexed_position] = player.token
  end

end
