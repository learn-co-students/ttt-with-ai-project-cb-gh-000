require 'pry'
class Game

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  attr_accessor :player_1, :player_2, :board

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def set_players_names
    self.player_1.name = "Player 1"
    self.player_2.name = "Player 2"
  end

  def current_player
    if self.board.turn_count % 2 == 0
      self.player_1
    else
      self.player_2
    end
  end

  def draw?
    self.board.full? && !self.won?
  end

  def over?
    self.won? || self.draw?
  end

  def won?
    winning_value = false
    WIN_COMBINATIONS.each do |win_combination|
      win_position1 = win_combination[0]
      win_position2 = win_combination[1]
      win_position3 = win_combination[2]

      win_token1 = self.board.cells[win_position1]
      win_token2 = self.board.cells[win_position2]
      win_token3 = self.board.cells[win_position3]

      if (win_token1 =="X" && win_token2 == "X" && win_token3 == "X") ||
        (win_token1 == "O" && win_token2 == "O" && win_token3 == "O")
        winning_value = win_combination
      end
    end
    winning_value
  end

  def winner
    if self.won?
      self.board.cells[self.won?[0]]
    end
  end

  def turn
    self.board.display
    player = self.current_player
    user_input = player.move(self.board)
    if self.board.valid_move?(user_input)
      self.board.update(user_input, player)
    else
      puts "Invalid move"
      turn
    end
  end

  def play
    self.set_players_names
    while !self.over?
      self.turn
    end
    if self.won?
      self.board.display
      puts "Congratulations #{self.winner}!"
    elsif self.draw?
      self.board.display
      puts "Cat's Game!"
    end
  end

end
