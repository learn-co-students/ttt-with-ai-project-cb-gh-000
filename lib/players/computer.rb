module Players
  class Computer < Player

    attr_accessor :win_combinations

    def move(board)

      enemy_strategy = pick_best_strategy(board, other_player_token)
      own_strategy = pick_best_strategy(board, @token)

      if enemy_strategy[:score] > own_strategy[:score]
        # defence
        puts "#{@token} is defending"
        pick_position(board, enemy_strategy[:combination])
      else
        # attack
        puts "#{@token} is attacking"
        pick_position(board, own_strategy[:combination])
      end
    end

    def calculate_score(board, token)
      @win_combinations.map do |combination|
        if board.positions_taken?(combination, true)
          score = 0
        else
          score = 0
          combination.each do |position|
            case board.position(position, true)
              when token
                score += 1
              when other_player_token
                score -= 1
            end
          end
          # score = combination.count do |position|
          #   board.position(position, true) == token
          # end
        end
        { score: score, combination: combination }
      end
    end

    def pick_best_strategy(board, token)
      strategies = calculate_score(board, token)
      strategies.max { |a, b| a[:score] <=> b[:score] }
    end

    def pick_position(board, combination)
      rand = rand(0..2)
      position = combination[rand]
      if board.valid_move?(position, true)
        position + 1
      else
        pick_position(board, combination)
      end
    end

  end
end


