require 'pry'

class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [[0, 1, 2],
                      [3, 4, 5],
                      [6, 7, 8],
                      [0, 3, 6],
                      [1, 4, 7],
                      [2, 5, 8],
                      [0, 4, 8],
                      [6, 4, 2]]

  def initialize(p1 = Players::Human.new("X"), p2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = p1
    @player_2 = p2
  end

  def current_player
    if self.board.turn_count % 2 == 0
      self.player_1
    else
      self.player_2
    end
  end

  def over?
    self.won? || self.draw?
  end

  def won?
    cells = self.board.cells
    WIN_COMBINATIONS.each do |comb|
      if cells[comb[0]] == cells[comb[1]] && cells[comb[1]] == cells[comb[2]] &&
         (cells[comb[0]] != " " || cells[comb[1]] != " ")
        return comb
      end
    end
    false
  end

  def draw?
    !won? && self.board.full?
  end

  def winner
    won = self.won?
    #binding.pry
    if won
      return self.board.cells[won[0]]
    end
    nil
  end

  def turn
    input = self.current_player.move(self.board)
    while !self.board.valid_move?(input) do
      input = self.current_player.move(self.board)
    end
    self.board.update(input, self.current_player)
  end

  def play
    self.board.display
    print "\n\n"
    until self.over?
      self.turn
      self.board.display
      print "\n\n"
      # binding.pry
    end
    if self.won?
      winner = self.winner
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
    winner
  end

end
