module Players
  class Human < Player

    def move(board)
      puts "Choose a position between 1 and 9"
      gets.strip
    end

  end
end
