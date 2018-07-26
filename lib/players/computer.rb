module Players
  class Computer < Player

    def move(board)
      puts "Where would you like to move (1-9)?"
      possible = board.cells.map.with_index { |box, index| (index.to_i + 1).to_s if box == " "}
      possible[Random.new.rand(possible.length)]
    end

  end
end
