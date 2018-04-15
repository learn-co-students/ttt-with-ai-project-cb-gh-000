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

  def initialize(player_1=nil, player_2=nil, board=nil)
    @player_1 = player_1 || Players::Human.new('X')
    @player_2 = player_2 || Players::Computer.new('O')
    @board = board || Board.new
  end

  def current_player
    @board.cells.count{|cell| cell == 'X' || cell == 'O'} % 2 == 0 ? @player_1 : @player_2
  end

  def over?
    draw? || won?
  end


  def won?
    WIN_COMBINATIONS.find do |comb|
      @board.cells[comb[0]] == @board.cells[comb[1]] &&
          @board.cells[comb[1]] == @board.cells[comb[2]] &&
          @board.taken?(comb[0] + 1)
    end
  end

  def draw?
    !won? && @board.full?
  end

  def winner
    @board.cells[won?.first] if won?
  end

  def turn
    player = current_player
    @board.display
    input = player.move(board)
    until @board.valid_move?(input)
      puts 'This position has been taken.' if @board.taken?(input)
      input = player.move(board)
    end
    @board.update(input, player)
  end

  def play
    until over?
      turn
    end
    if draw?
      @board.display
      puts "Cat's Game!"
    elsif won?
      @board.display
      puts "Congratulations #{winner}!"
    end
  end


end