module Players
  class Human < Player
    def move(cells)
      puts "Enter a number between 1 and 9"
      gets.strip
    end
  end
end
