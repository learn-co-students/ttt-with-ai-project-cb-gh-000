class Players
  class Computer < Player
    PRIOR = [4, 0, 2, 6, 8, 1, 3, 5, 7]
    
    def move(board)
      puts "Now is the Computer's round."
      @board = board.cells
      result = win_move(self.token)
      return self.index_to_input(result) if result
      result = win_move(self.token == "X" ? "O" : "X")
      return self.index_to_input(result) if result
      result = self.prior_move ? self.prior_move : PRIOR.sample
      puts "Computer move to #{result + 1}th cell."
      self.index_to_input(result)
    end

    def win_move(character)
      moved = []
      @board.each_with_index do |i, index|
        moved << index if i == character
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
      PRIOR.each do |move|
        return move if !self.taken?(move)
      end
    end

    def taken?(index)
      @board[index] != " "
    end

    def index_to_input(index)
      (index + 1).to_s
    end
  end
end