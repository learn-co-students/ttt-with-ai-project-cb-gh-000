class Board

  attr_accessor :cells

  def initialize
    @cells = Array.new(9, " ")
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def board
    @cells
  end
  def display
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def position index
    index = to_integer index
    board[index-1]
  end

  def full?
    board.all?{|position| position == "X" || position == "O"}
  end

  def turn_count
    board.count{|position| position == "X" || position == "O"}
  end

  def taken?(index)
    index = to_integer index
    !(board[index-1].nil? || board[index-1] == " ")
  end

  def valid_move?(index)
    index = to_integer index
    index > 0 && index.between?(1,9) && !taken?(index)
  end

  def update index, player
    index = to_integer(index)
    @cells[index-1] = player.token
  end

  private

  def to_integer str
    str.to_i
  end

end
