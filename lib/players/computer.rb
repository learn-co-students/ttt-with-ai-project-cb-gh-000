module Players
  class Computer < Player
    def move(board)
      (board.free_cells.sample + 1).to_s
    end
  end
end
