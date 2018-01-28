
class Board
  
  attr_accessor :cells
  
  def initialize
    @cells = Array.new(9," ")
  end
  
  def reset!
    self.cells = Array.new(9," ")
  end
  
  def display 
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "-----------"
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "-----------"
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end
  
  def position(position)
    user_input = position.to_i - 1
    cells[user_input]
  end
  
  def full?
    cells.all?{ |cell| !(cell == " " || cell == "" || cell == nil ) }
  end
  
  def turn_count
    cells.reject{|cell| cell == " " || cell == "" || cell == nil}.count
  end
  
  def taken?(position)
    user_input = position.to_i - 1
    if cells[user_input] != " " 
      return true 
    else 
      return false
    end
  end
  
  def valid_move?(position)
    (1..9).include?(position.to_i) && !taken?(position)
  end
  
  def update(position,player)
    cells[position.to_i - 1] = player.token
  end
  
end


