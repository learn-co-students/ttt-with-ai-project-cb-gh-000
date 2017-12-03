require "pry"
class Board
  attr_accessor :cells
  def initialize
    @cells = [" "] * 9
  end

  def reset!
    @cells = []
    9.times { @cells << " "}
  end

  def display
    board = self.cells
      .map { |e| " #{e} " }
      .each_slice(3).to_a
      .map { |e| e.join("|") }
      .join "-----------"
    puts board
  end

  def index(input)
    input.strip.to_i - 1
  end
  
  def position(pos)
    pos = self.index(pos)
    self.cells[pos] if pos>=0 && pos<9
  end

  def turn_count
    self.cells.count{|token| token == "X" || token == "O"}
  end

  def taken?(pos)
    cell = self.position(pos)
    ["X", "O"].include?(cell) if cell
  end

  def valid_move?(index)
    v = self.taken?(index)
    !v unless v.nil?
  end

  def full?
    self.cells.all? { |e| ["X", "O"].include?(e.upcase) }
  end

  def update(input, player)
    self.cells[self.index(input)] = player.token if self.valid_move?(input)
  end
end
# binding.pry
