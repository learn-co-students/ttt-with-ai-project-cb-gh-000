module Players
  class Human < Player
    # your code here
    def move(moves)
      puts "Please input your move:"
      c = gets.strip
      moves << c
      c
    end
  end
end
