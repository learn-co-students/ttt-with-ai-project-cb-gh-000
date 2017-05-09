require_relative'../config/environment'

class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
      [0,1,2],[3,4,5],[6,7,8],
      [0,3,6],[1,4,7],
      [2,5,8],[0,4,8],[6,4,2]
  ]

  def initialize(player_1 = nil, player_2 = nil, board = nil)
    @player_1 = player_1 || Players::Human.new("X")
    @player_2 = player_2 || Players::Human.new("O")
    @board = board || Board.new
  end

  def current_player
    @board.turn_count.even? ? @player_1 : @player_2
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      board_positions = combination.map { |position| @board.cells[position] }.join
      return @player_1 if board_positions == 'XXX'
      return @player_2 if board_positions == 'OOO'
    end
    false
  end

  def over?
    draw? || won?
  end

  def draw?
    @board.full? && !won?
  end

  def winner
    winner = won?
    winner.token if winner
  end

  def turn
    puts 'Please type a position from 1 to 9.'
    position = current_player.move(@board)

    return turn unless @board.valid_move?(position)

    @board.update(position, current_player)
    @board.display
  end

  def play
    turn until over?
    puts draw? ? "Cat's Game!" : "Congratulations #{ winner }!"
  end

end
