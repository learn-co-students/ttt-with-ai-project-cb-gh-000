class Game
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],

    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],

    [0, 4, 8],
    [2, 4, 6]
  ]

  attr_accessor :player_1, :player_2, :board

  def initialize(player_1 = Players::Human.new("X"),
                 player_2 =  Players::Human.new("O"), board = Board.new)

    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def board
    @board
  end

  def player_1
    @player_1
  end

  def player_2
    @player_2
  end

  def current_player
    (board.turn_count % 2 == 0) ? player_1 : player_2
  end

  def over?
    draw? or won?
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      (combo.all? {|e| board.cells[e] == "X"} ||
       combo.all? {|e| board.cells[e] =="O"}) ? true : false
    end
  end

  def draw?
    board.full? and !won?
  end

  def winner
    WIN_COMBINATIONS.detect do |combo|
      if combo.all? {|i| board.cells[i] == "X"}
        return "X"
      elsif combo.all? {|i| board.cells[i] == "O"}
        return "O"
      end
    end
  end

  def turn
    puts
    puts "_________________________________________"
    puts "Enter a number (1-9) where you want to go"

    input = current_player.move(board)
    if board.valid_move?(input)
      if current_player.class == Players::Human
        puts "You picked spot #{input}"
      else
        puts "Computer picked spot #{input}"
      end
      board.update(input, current_player)
      board.display
    else
      puts "Invalid move received"
      turn
    end
  end

  def play
    puts
    board.display
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
