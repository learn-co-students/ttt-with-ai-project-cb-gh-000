class Board
  attr_accessor :cells

  def initialize
    @cells = Array.new(9,' ')
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def reset!
    @cells = Array.new(9,' ')
  end

  def position(input)
    index = to_index(input)
    if index >= 0 && index <9
      @cells[index]
    end
  end

  def full?
    @cells.count{|x| x=='O' || x=='X'} == 9
  end

  def turn_count
    @cells.count{|x| x=='O' || x=='X'}
  end

  def taken?(input)
    index = to_index(input)
    @cells[index] == 'O' || @cells[index] == 'X'
  end

  def to_index(input)
    input.to_i - 1
  end

  def valid_move?(input)
    index = to_index(input)
    !taken?(input) && index >= 0 && index < 9
  end

  def update(input,player)
    if valid_move?(input)
      @cells[to_index(input)] = player.token
    end
  end


end
