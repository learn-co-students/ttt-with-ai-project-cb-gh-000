module Players
  class Computer < Player
    def move(board)
      token = self.token
      res = ""
      weight = 0
      choices = ["1", "2", "3", "4", "5", "6", "7", "8", "9"].select{ |x| !board.taken?(x) }
      my_turns = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        .select { |x| board.taken?(x) && board.cells[x.to_i - 1] == token }
        .map { |x| x.to_i - 1 }
      opp_turns = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        .select { |x| board.taken?(x) && board.cells[x.to_i - 1] != token }
        .map { |x| x.to_i - 1 }

      if choices.length > 1
        win_pos = best_pos(my_turns, choices)
        block_pos = best_pos(opp_turns, choices)

        if my_turns.length > 1 && win_pos
          res = win_pos
        elsif opp_turns.length > 1 && block_pos
          res = block_pos
        else
          choices.each do |choice|
            current_weight = Game::WIN_COMBINATIONS.count { |x| x.include?(choice.to_i - 1) }
            if current_weight >= weight
              weight = current_weight
              res = choice
            end
          end
        end
      else
        res = choices[0]
      end

      res
    end

    def best_pos(turns, choices)
      res = false
      combs = []

      for i in 0..turns.length - 2
        for j in 1..turns.length - 1
          choices.each { |x| combs << [turns[i], turns[j], x.to_i - 1].sort }
        end
      end

      combs.uniq.each do |x|
        if Game::WIN_COMBINATIONS.include?(x)
          x.each do |index|
            pos = (index + 1).to_s
            res = pos if choices.include?(pos)
          end
        end
      end

      res
    end
  end
end
