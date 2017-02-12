class Game

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

  attr_accessor :board, :player_1, :player_2

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new())
    @player_1 = player_1
    @player_2 = player_2
    @board = board
    @winner = nil
  end

  def current_player
    token = (board.turn_count % 2 == 0) ? "X" : "O"
    token.eql?(@player_1.token) ? @player_1 : @player_2
  end

  def won?
    WIN_COMBINATIONS.each do |combo|
      if @board.cells[combo[0]].eql?(@board.cells[combo[1]]) and @board.cells[combo[2]].eql?(@board.cells[combo[0]])
        if !@board.cells[combo[0]].eql?(" ")
          @winner = @board.cells[combo[0]]
          return true
        end
      end
    end
    false
  end

  def over?
    self.won? or @board.full?
  end

  def draw?
    (@board.full? and !self.won?) ? true : false
  end

  def winner
    self.won?
    @winner
  end

  def turn
    player = self.current_player
    loop do
      input = player.move
      if @board.update(input, self.current_player)
        break
      end
    end
  end

  def play
    while (!self.over?) do
      self.turn
      if self.draw?
        break
      end
    end
    if self.draw?
      puts "Cat's Game!"
    else
      puts "Congratulations #{@winner}!"
    end
  end

  def start
  end

end
