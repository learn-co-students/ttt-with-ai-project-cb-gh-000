require_relative'../config/environment'

class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
      [0,1,2],[3,4,5],[6,7,8],
      [0,3,6],[1,4,7],
      [2,5,8],[0,4,8],[6,4,2]
  ]

  def initialize(player_1 = nil, player_2 = nil, board = nil)
    @player_1 = player_1 || Players::Human.new('X')
    @player_2 = player_2 || Players::Human.new('O')

    @player_1.win_combinations = WIN_COMBINATIONS if player_1.class == Players::Computer
    @player_2.win_combinations = WIN_COMBINATIONS if player_2.class == Players::Computer

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
    current_player = self.current_player

    position = current_player.move(@board)
    return turn unless @board.valid_move?(position)

    @board.update(position, current_player)
    @board.display
  end

  def play
    turn until over?
    puts draw? ? 'Cat\'s Game!' : "Congratulations #{ winner }!"
  end


  def self.welcome
    puts 'WELCOME TO DAN-TAC-TOE'
    puts '----------------------'
  end

  def self.game_mode
    puts 'Select game mode:'
    puts '0. CPU vs CPU'
    puts '1. PLAYER vs. CPU'
    puts '2. PLAYER vs. PLAYER'
    gets.chomp
  end

  def self.ask_first
    puts 'Which user should go first?'
    puts 'Type X or O'
    input = gets.chomp
    input != '' ? input : 'X'
  end

  def self.start
    welcome
    case game_mode
    when '1'
      start_single_player
    when '2'
      start_two_player
    when 'wargames'
      start_wargames
    else
      start_cpu_game
    end
  end

  def self.start_single_player
    Game.new(Players::Human.new('X'), Players::Computer.new('O')).play
  end

  def self.start_two_player
    first = Players::Human.new(ask_first)
    second = Players::Human.new(first.other_player_token)
    Game.new(first, second).play
  end

  def self.start_cpu_game
    Game.new(Players::Computer.new('X'), Players::Computer.new('O')).play
  end

  def self.start_wargames
    Wargame.new.play
  end

end
