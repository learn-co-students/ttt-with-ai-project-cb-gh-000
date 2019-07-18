module Players
  class Human < Player

    attr_reader :name

    def name=(name)
      @name = name
    end

    def move(board)
      puts "#{self.name}! with token of '#{self.token}' Enter a valid move 1 - 9: "
      move = gets.strip
    end

  end
end
