class Board

  attr_accessor :cells

  def initialize
    self.reset!
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    @cells.each_with_index do |cell, index|
      if index % 3 == 0
        puts " #{@cells[index]} | #{@cells[index+1]} | #{@cells[index+2]} "
        if index != 0
          puts "-----------"
          puts "   |   |   "
        end
      end
    end
  end

  def position(input)
    @cells[input.to_i - 1]
  end

  def full?
    @cells.each do |cell|
      if cell.eql?(" ")
        return false
      end
    end
    true
  end

  def turn_count
    cells = []
    @cells.each do |cell|
      if !cell.eql?(" ")
        cells.push(cell)
      end
    end
    cells.size
  end

  def taken?(input)
    !position(input).eql?(" ") ? true : false
  end

  def valid_move?(input)
    if input.to_i - 1 < 0 or input.to_i - 1 > 8
      return false
    elsif !taken?(input)
      return true
    end
    false
  end

  def update(input, player)
    if valid_move?(input)
      @cells[input.to_i - 1] = player.token
      true
    else
      false
    end
  end
end
