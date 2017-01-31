class Players
  class Human < Player
    def move(board)
      puts "Which cell do you want to move?"
      input = ""
      input = gets.strip
    end
  end
end
