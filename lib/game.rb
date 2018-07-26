

class Game
  attr_accessor :board, :player_1, :player_2
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

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    self.board.turn_count.even? ? self.player_1 : self.player_2
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      combo.all? {|i| self.board.cells[i] == self.board.cells[combo[0]] && self.board.taken?(i+1)}
    end
  end

  def draw?
    !self.won? && self.board.full?
  end

  def over?
    self.draw? || self.won?
  end

  def winner
    self.board.cells[won?.first] if won?
  end

  def turn
    self.board.display
    puts "It's your turn, player #{self.current_player.token}. Select 1-9."
    input = self.current_player.move(self.board)
    if self.board.valid_move?(input)
      self.board.update(input, self.current_player)
    else
      puts "That is not a valid move. Please choose again."
      self.turn
    end
  end

  def play
    until self.draw? || self.over?
      self.board.display
      self.turn
    end
    if self.winner
      puts "Congratulations #{self.winner}!"
    elsif self.draw?
      puts "Cat's Game!"
    end
  end

  def start
    puts "Welcome to TicTacToe!\n\n"
    puts "How many players will there be? (0, 1, or 2)"
    player_count = gets.chomp
    if(player_count == "0")
      puts "\nJust want to watch the ai duke it out. Fair enough.\n\n"
      player_1 = Players::Computer.new("X")
      player_2 = Players::Computer.new("O")
    elsif player_count == 1
      puts "\nYou want to take on the AI? Humans against machines doesn't seem fair. You can go first...\n\n"
      player_1 = Players::Human.new("X")
      player_2 = Players::Computer.new("O")
    else
      puts "Okay then. There will be two of you. Player 1, what do you want your token top be? (X, O, :). etc. )\n\n"
      starter = gets.chomp
      puts "And the token for player 2?"
      second = gets.chomp
      player_1 = Players::Human.new(starter)
      player_2 = Players::Human.new(second)
    end

  end

end
