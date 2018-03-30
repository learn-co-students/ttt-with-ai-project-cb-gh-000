module Players
  class Computer < Player
    def move(board)
      result = 0
      board.cells.each_with_index do |x,i|
        if x == ' '
          result = i
          break
        end
      end
      (result+1).to_s
    end
  end
end
