class Players
  class Human < Player
    def move(board)
      puts "Now is the #{self.token}'s round, which cell do you want to move?"
      input = ""
      input = gets.strip
    end
  end
end
