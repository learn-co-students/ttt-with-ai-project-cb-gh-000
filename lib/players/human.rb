module Players
  class Human < Player

    def move(board)
      puts "Enter a valid move 1 - 9: "
      move = gets.strip
    end

  end
end
