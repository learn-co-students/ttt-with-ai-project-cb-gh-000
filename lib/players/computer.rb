module Players
  class Computer < Player

    # random strategy AI

    def move(board)
      (board.free_cells.sample+1).to_s
    end

  end
end
