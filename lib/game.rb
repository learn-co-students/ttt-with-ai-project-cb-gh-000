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
    token = board.turn_count.even? ? "X" : "O"
    token.eql?(@player_1.token) ? @player_1 : @player_2
  end

  def won?
    WIN_COMBINATIONS.any?{|combo|
      @board.cells[combo[0]].eql?(@board.cells[combo[1]]) &&
      @board.cells[combo[1]].eql?(@board.cells[combo[2]]) &&
      !@board.cells[combo[0]].eql?(" ")
    }
  end

  def over?
    won? || draw?
  end

  def draw?
    @board.full? && winner.nil?
  end

  def winner
    WIN_COMBINATIONS.collect{|combo|
      (@board.cells[combo[0]].eql?(@board.cells[combo[1]]) &&
       @board.cells[combo[1]].eql?(@board.cells[combo[2]]) &&
       !@board.cells[combo[0]].eql?(" ")) || nil
    }.compact.first
  end

  def turn
    loop do
      puts "#{current_player.token} turn:"
      @board.update(current_player.move(@board), current_player) ? break : next
    end
  end

  def play
    while (!over?) do
      turn
      @board.display
      draw? ? break : next
    end
    draw? ? puts "Cat's Game!" : puts "Congratulations #{@winner}!"
  end

  def start(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new())
    @player_1 = player_1
    @player_2 = player_2
    @board = board
    play
  end

end
