class Board

  attr_accessor :cells

  def initialize
    @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def reset!
    self.cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display
    b = self.cells
    output  = " #{b[0]} | #{b[1]} | #{b[2]} \n"
    output += "-----------\n"
    output += " #{b[3]} | #{b[4]} | #{b[5]} \n"
    output += "-----------\n"
    output += " #{b[6]} | #{b[7]} | #{b[8]} \n"
    puts output
  end

  def position(input)
    self.cells[input.to_i - 1]
  end

  def full?
    self.cells.all? do |cell|
      cell != " "
    end
  end

  def turn_count
    res = 0
    self.cells.each do |cell|
      if cell != " "
        res += 1
      end
    end
    res
  end

  def taken?(input)
    i = input.to_i - 1
    res = false
    if self.cells[i] != " "
      res = true
    end
    res
  end

  def valid_move?(input)
    res = false
    if input.to_i > 0 && input.to_i < 10 && !taken?(input)
      res = true
    end
    res
  end

  def update(i, player)
    if valid_move?(i)
      self.cells[(i.to_i - 1)] = player.token
    end
  end
  
end