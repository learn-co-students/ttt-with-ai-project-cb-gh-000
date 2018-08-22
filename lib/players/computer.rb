module Players
  class Computer < Player
    attr_accessor :opponent

    def initialize(token)
      super
      @opponent = if self.token == 'X'
                    'O'
                  else
                    'X'
                  end
    end

    def move(board)
      test_board = Board.new
      test_board.cells = board.cells.clone
      test_board.cells.each_with_index do |_cell, index|
        next unless test_board.valid_move?(index + 1)
        test_board.cells[index] = @opponent
        return (index + 1).to_s if won?(test_board)
      end
      [1..9].sample.to_s
    end

    def won?(board)
      WIN_COMBINATIONS.each do |combo|
        next unless board.cells[combo[0]] == @opponent && board.cells[combo[0]] == board.cells[combo[1]] && board.cells[combo[1]] == board.cells[combo[2]]
        next unless combo.all? do |index|
          board.taken?(index + 1)
        end
        return true
        break
      end
      false
    end

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [6, 4, 2],
        [0, 4, 8]
    ].freeze
  end
end
