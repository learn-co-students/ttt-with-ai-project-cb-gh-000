class Game

WIN_COMBINATIONS = [
    [0,1,2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  attr_accessor :board, :player_1, :player_2
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new"O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    @board.turn_count % 2 == 0 ? @player_1 : @player_2
  end

def won?
    x = 0
  o = 0
    position_value = ""
    WIN_COMBINATIONS.each do |combination|
      combination.each do |e|
        position_value = @board.position(e + 1)
        if position_value == "X"
          x += 1
        elsif position_value == "O"
        o += 1
        end
      end
      if x == 3 || o == 3
        return combination
      else
        x = 0
        o = 0
       end
    end
  false
  end

  def draw?
    @board.full? && self.won? == false
end

  def over?
  self.draw? || self.won?
end

  def winner
    won_combination = self.won?
    winner = nil
    if self.draw? == false && won_combination != false
      winner = @board.position(won_combination.first + 1) == "X" ? "X" : "O"
    end
  end

  def turn
    player = self.current_player
    player_move = player.move(@board)
    if @board.valid_move?(player_move)
      @board.update(player_move, player)
    else
      turn
    end
  end

  def play
    until over?
      self.turn
    end
    player = winner
    puts player != nil ?  "Congratulations #{player}!" : "Cat's Game!"
  end
end