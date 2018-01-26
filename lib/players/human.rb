module Players
  class Human < Player
    def move(board)
    	puts "Make a Move! Input a val between 1 - 9"
    	gets.strip
    end
  end
end
