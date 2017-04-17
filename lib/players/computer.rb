module Players
  class Computer < Player
    def move(board)
      i = 1
      while i < 10 && board.taken?(i.to_s)
        i += 1
      end
      i.to_s
    end
  end
end
