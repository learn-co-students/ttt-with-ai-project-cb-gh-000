module Players
  class Computer < Player
    def move(board)
      @board = board
      @pattern = Game::WIN_COMBINATIONS
      @opponent = self.token == 'X' ? 'O' : 'X'
      tactic = nil

      if tactic_1
        tactic = tactic_1[2]+1
      elsif tactic_2
        tactic = tactic_2[1]+1
      elsif tactic_3
        tactic = tactic_3[0]+1
      end


      tactic

    end

    private
    def tactic_1
      @pattern.detect do |combo|
        @board.cells[combo[0]] == @opponent && @board.cells[combo[1]] == @opponent && !@board.taken?(combo[2]+1)
      end
    end

    def tactic_2
      @pattern.detect do |combo|
        @board.cells[combo[0]] == @opponent && !@board.taken?(combo[1]+1)
      end
    end

    def tactic_3
      @pattern.detect do |combo|
        !@board.taken?(combo[0]+1)
      end
    end

  end
end