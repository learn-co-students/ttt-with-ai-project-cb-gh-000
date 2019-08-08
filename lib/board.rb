class Board

  attr_accessor :cells

  def initialize
    reset!
  end

  def reset!
    @cells = [" "," "," "," "," "," "," "," "," "]
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    puts ""
  end

  def position(pos)
    @cells[pos.to_i - 1]
  end

  def full?
    !@cells.detect {|x| x == " "}
  end

  def turn_count
    @cells.find_all {|x| x == "X" || x == "O"}.length
  end

  def taken?(pos)
    return true if position(pos) == "X" || position(pos) == "O"
    return false if position(pos) == " "
  end

  def valid_move?(pos)
    return true if !taken?(pos) && 1 <= pos.to_i && pos.to_i <= 9
    return false if taken?(pos) || pos.to_i < 1 || pos.to_i > 9
  end

  def update(pos, player)
    if valid_move?(pos)
      @cells[pos.to_i - 1] = player.token
      true
    end
  end



end
