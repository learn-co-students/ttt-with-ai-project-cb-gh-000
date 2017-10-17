class Board
  attr_accessor :cells
  EMPTY_BOARD = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '].freeze

  def initialize(cells = Board.empty_board)
    @cells = cells
  end

  def self.empty_board
    EMPTY_BOARD.dup
  end

  def reset!
    # reset board array to all " "
    @cells = Board.empty_board
  end

  def display
    # display current board state as a 3x3 matrix
    separator = "-----------"
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts separator
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts separator
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end

  def position(input)
    # accepts a user input in form of 1-9 string and looks up the value of the
    # array index corresponding to the given input
    @cells[input.to_i - 1]
  end

  def update(input, player)
    # given a position, if it's free update the corresponding element with the
    # #token of the given player
    if valid_move?(input)
      @cells[input.to_i - 1] = player.token
    end
  end

  def full?
    # returns whether the board is full (entirely occupied with ' X ' or ' O ')
    @cells.all? { |cell| cell =~ /[XO]/}
  end

  def turn_count
    # returns the current turn number, based on the number of filled cells
    @cells.count { |cell| cell =~ /[XO]/}
  end

  def taken?(input)
    # returns whether the given position is already occupied
    !!(position(input) =~ /[XO]/)
  end

  def valid_move?(input)
    # ensures that the position is between 1-9 and not taken
    !!(input.to_s =~ /[1-9]/) && !taken?(input)
  end
end
