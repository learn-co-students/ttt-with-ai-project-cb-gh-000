module Players
  class Computer < Player
    attr_accessor :board
    WIN_COMBINATIONS = Game::WIN_COMBINATIONS


    def move(board)
      minimax(board, -1)
      @move_index + 1
    end

    private

    def minimax(board, depth)
      return score(board, depth) if over?(board)
      depth += 1
      scores = []
      moves = []

      get_free_spaces(board).each do |free|
        cell_backup = board.cells[free]
        board.cells[free] = player_in_depth(depth)

        moves << free
        scores << minimax(board, depth)

        board.cells[free] = cell_backup
      end

      if player_in_depth(depth) == 'X'
        max_index = scores.each_with_index.max[1]
        @move_index = moves[max_index]
        scores[max_index]
      else
        min_index = scores.each_with_index.min[1]
        @move_index = moves[min_index]
        scores[min_index]
      end

    end

    def get_free_spaces(board)
      spaces = []
      board.cells.each_with_index do |cells, index|
        spaces << index if (cells != 'X' && cells != 'O')
      end
      spaces
    end

    def score(board, depth)
      if won?(board)
        if player_in_depth(depth) == "O"
          depth - 10
        elsif player_in_depth(depth) == "X"
          10 - depth
        end
      else
        0
      end
    end

    def player_in_depth(depth)
      opposing_player = self.token == 'X' ? 'O' : 'X'
      depth % 2 ==0 ? self.token : opposing_player
    end

    def won?(board)
      WIN_COMBINATIONS.find do |comb|
            board.cells[comb[0]] == board.cells[comb[1]] &&
            board.cells[comb[1]] == board.cells[comb[2]] &&
            board.taken?(comb[0] + 1)
      end
    end

    def draw?(board)
      !won?(board) && board.full?
    end

    def over?(board)
      draw?(board) || won?(board)
    end

  end
end