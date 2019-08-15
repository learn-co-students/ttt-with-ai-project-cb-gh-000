module Players
  class Human < Player
    def move(board)
      puts "Enter a move:"
      gets.chomp
    end
  end
end
