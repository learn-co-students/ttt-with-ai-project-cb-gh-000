module Players
  class Computer < Player
    def move(board)
      (1..9).to_a.detect { |input| board.valid_move?(input.to_s) }.to_s
    end
  end
end
