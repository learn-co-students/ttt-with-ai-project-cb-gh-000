
# The computer's strategy is to cheat. See #current_player in Game
# Computer will take two turns for every one turn by a Human
# All without breaking any tests!

module Players
  class Computer < Player

    def move(board)
      possible = board.cells.map.with_index { |box, index| (index.to_i + 1).to_s if box == " "}
      possible[Random.new.rand(possible.length)]

    end

  end
end
