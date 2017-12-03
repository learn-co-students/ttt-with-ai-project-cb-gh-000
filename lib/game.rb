require "players/human"
require "board"
require "pry"

class Game
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # Right column
    [1,4,7], # Middle column
    [2,5,8], # Left column
    [0,4,8], # Diagonals
    [2,4,6]  # Diagonals
  ]

  attr_accessor :board, :player_1, :player_2
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    self.board    = board
    self.player_1 = player_1
    self.player_2 = player_2
  end

  def current_player
    self.board.turn_count % 2 == 0 ? self.player_1 : self.player_2
  end

  def full?
    self.board.full?
  end

  def draw?
    self.full? && !self.won?
  end

  def won?
    unless self.board.cells.empty? || !self.board.cells || self.board.cells.all? { |e| e == "" || e == " " || !e  }
      WIN_COMBINATIONS.each do |e|
         player = e.map { |el| self.board.cells[el] }.uniq
         return e if player.length == 1 && player[0] != " "
      end
    end
    nil
  end

  def over?
    self.full? || self.draw? || self.won?
  end

  def winner
    temp = self.won?
    return self.board.cells[temp[0]] if temp
  end

  def turn
    puts "Please enter 1-9:"
    choice = self.current_player.move([])
    if self.board.valid_move?(choice)
      self.board.update(choice, self.current_player)
      self.board.display
    else
      self.turn
    end
  end

  def play
    until self.over?
      self.turn
    end
    if self.won?
      puts "Congratulations #{self.winner}!"
    else
      puts "Cat\'s Game!"
    end
  end
end

binding.pry
