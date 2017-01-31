class Players
  class Computer < Player
    PRIOR = {
      1: [4],
      2: [0, 2, 6, 8]
      3: [1, 3, 5, 7]
    }
    
    def move(board)
      @board = board
      if @board.select{|i| i == self.token}.size >= 2
        win_move_result = self.win_move
        if !win_move_result
          self.prior_move
        else
          win_move_result
        end
      else
        self.prior_move
      end
    end

    def win_move
      moved = []
      @board.each_with_index do |i, index|
        moved << index if i == self.token
      end
      Game::WIN_COMBINATIONS.each do |arr|
        arr_copy = arr.dup
        arr_copy.collect! do |place|
          moved.include?(place) ? -1 : place
        end
        if arr_copy.select{|i| i != -1}.size <= 1
          arr_copy.each do |i|
            return i unless i == -1 || self.taken?(i)
          end
        end
      end
      false
    end

    def prior_move
    end

    def taken?(index)
      board[index] != " "
    end
  end
end