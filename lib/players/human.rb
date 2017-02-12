module Players

  class Human < Player
    def move(board = [])
      input = gets
      input.chomp
    end
  end
end
