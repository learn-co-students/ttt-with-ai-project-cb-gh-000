require 'player'
module Players
  class Human < Player
    def move(board)
      input = gets
      return input
    end
  end

  class Computer < Player
    def move(board)
      "1"
    end
  end

end
