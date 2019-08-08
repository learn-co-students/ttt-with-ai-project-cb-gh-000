module Players

  class Computer < Player

    def move(board)
      puts "Thinking..."
      sleep(3)
      if board.turn_count == 0
        x = rand(1..9).to_s
        puts "I choose position #{x.to_i}"
        return x
      end
      remainingSpaces = []
      count = 1
      board.cells.each do |cell|
        if cell == " "
          remainingSpaces << count
        end
        count += 1
      end
      x = remainingSpaces.sample
      puts "I choose position #{x.to_i}"
      return x
    end
  end

end
