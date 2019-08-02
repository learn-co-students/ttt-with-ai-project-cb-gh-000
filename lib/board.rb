class Board
  attr_accessor :cells

  def initialize
    self.reset!
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

  def position(inp)
    return @cells[inp.to_i-1]
  end

  def full?
    @cells.each do |cell|
      if cell == " "
        return false
      end
    end
    return true
  end

  def turn_count
    count = 0

    @cells.each do |cell|
      if(cell != " ")
        count  += 1
      end
    end

    return count
  end

  def taken?(pos)
    if position(pos) == " "
      return false
    else
      return true
    end
  end

  def valid_move?(input)
    if(input.to_i > 0 && input.to_i < 10 && !taken?(input))
      return true
    else
      return false
    end
  end

  def update(input, player)
    @cells[input.to_i - 1] = player.token
  end
end
