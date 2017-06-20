module Players
  class Computer < Player

    def move(board)
      @choices = []

      # For AI being second
      if board.turn_count == 1
        return !board.taken?(5) ? "5" : [1, 3, 7, 9].sample.to_s
      elsif board.turn_count % 2 != 0
        temp_board = board
        minimax(temp_board, 0, true, -Float::INFINITY, Float::INFINITY)
        return (@choices.last + 1).to_s
      end

      # For AI being first
      if board.turn_count == 0
        return "5"
      elsif board.turn_count == 2
        if [1, 3, 7, 9].detect { |i| i != " " }
          return [2, 4, 6, 8].sample.to_s
        else
          return [1, 3, 7, 9].sample.to_s
        end
      elsif board.turn_count % 2 == 0
        temp_board = board
        minimax(temp_board, 0, false, -Float::INFINITY, Float::INFINITY)
        return (@choices.last + 1).to_s
      end

    end

    # Minimax algorithm followed approach from http://neverstopbuilding.com/minimax
    # Assumes "X" is first player and "O" is second player
    # added a random factor to the evaluate function to weaken AI
    # added alpha beta pruning
    def minimax(board, depth, player, alpha, beta)
      if won?(board) or (!won?(board) and board.full?)
        return evaluate(board, depth, player)
      end
      scores = []
      index_moves = []

      depth += 1
      board.empty_indices.each do |index|
        if player
          scores << minimax(board.create_newTemp_board("O", index),
                                                depth, false, alpha, beta)
          index_moves << index
        else
          scores << minimax(board.create_newTemp_board("X", index),
                                                depth, true, alpha, beta)
          index_moves << index
        end
      end

      if player
        max_index = scores.each_with_index.max[1]
        alpha = scores[max_index] > alpha ? scores[max_index] : alpha

        if beta > alpha
          @choices << index_moves[max_index]
          return alpha
        end

      else
        min_index = scores.each_with_index.min[1]
        beta = scores[min_index] < beta ? scores[min_index] : beta

        if beta > alpha
          @choices << index_moves[min_index]
          return beta
        end

      end
    end

    def evaluate(board, depth, player)
      random = Random.new
      done = won?(board)
      if done and player
        return (random.rand > 0.65) ? (random.rand(depth) + 1) : depth - 10
      elsif done and !player
        return (random.rand > 0.65) ? (random.rand(depth) + 1) : 10 - depth
      else
        return 0
      end
    end

    private

    def won?(board)
      Game::WIN_COMBINATIONS.detect do |combo|
        (combo.all? {|e| board.cells[e] == "X"} ||
         combo.all? {|e| board.cells[e] =="O"}) ? true : false
      end
    end

  end
end
