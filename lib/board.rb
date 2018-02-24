class Board
  attr_accessor :cells

  def initialize()
    @cells = Array.new(9, " ")
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{cells[0]} " + "|" + " #{cells[1]} " + "|" + " #{cells[2]} "
    puts "-----------"
    puts " #{cells[3]} " + "|" + " #{cells[4]} " + "|" + " #{cells[5]} "
    puts "-----------"
    puts " #{cells[6]} " + "|" + " #{cells[7]} " + "|" + " #{cells[8]} "
  end

  def position(idx)
    cells[idx.to_i - 1]
  end

  def full?
    !cells.include?(" ")
  end

  def turn_count
    cells.count { |c| c if c != " " }
  end

  def taken?(idx)
    cells[idx.to_i - 1] == " " ? false : true
  end

  def valid_move?(idx)
    !taken?(idx) && idx.to_i.between?(1,9)
  end

  def update(idx, player)
    cells[idx.to_i - 1] = player.token
  end
end
