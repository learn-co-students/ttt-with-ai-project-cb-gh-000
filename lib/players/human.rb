module Players
  class Human < Player

    def initialize(token)
      super
    end

    def move(board)
      move = super
    #   if board.valid_move?(move)
    #     board.update(move, self)
    #   end
    end



  end
end