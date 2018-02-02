module Players
  class Human < Player
    def move(board)
      board.display
      puts "Please enter a valid number from 1-9:"
      gets.strip
    end
  end
end
