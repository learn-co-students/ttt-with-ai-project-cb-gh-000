require "pry"


module Players
  class Computer < Player
    #The dumbest AI in tha world
    def move(board)
      result = nil
      moves = [*1..9]
      moves.each do |cell|
        if board.taken?(cell.to_s) == false
          result = cell
          break
        end
      end
      result.to_s
    end

  end
end
