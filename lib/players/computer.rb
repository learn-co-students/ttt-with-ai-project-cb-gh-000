module Players
  class Computer < Player

    def move(board)
      # we get a random number, check if it's valid and if it is we return it
      rnd = (1 + rand(9)).to_s
      while !board.valid_move?(rnd)
        rnd = (1 + rand(9)).to_s
      end
      rnd
    end
  end

  class SmartAI < Player
    # this class will try to play a meaningful first move and try to align 3 tokens
    # but will not hinder the player from winning
    
    attr_accessor :moves
    
    def initialize(token)
      super(token)
      @moves = []
    end

    def move(board)
      # the AI's first turn should be played on a corner preferably
      if board.turn_count == 0 || board.turn_count == 1
        # if the player moved first and on a corner, only option is the center
        if !board.valid_move?("1") || !board.valid_move?("4") || !board.valid_move?("7") || !board.valid_move?("9")
          return "5"
        else
          # if not, we can take a corner
          return board.valid_move?("1") ? "1" : "3"
        end
      else
        # we go over win combinations and see if our moves can apply to any of them
        Game::WIN_COMBINATIONS.each do |combo|
          self.moves.each do |move|
            if combo.include?(move.to_i)
              # we'll get the relevant combo indexes
              i = combo.index(move.to_i)

              case i
              when 0
                c1 = combo[1]
                c2 = combo[2]
              when 1
                c1 = combo[0]
                c2 = combo[2]
              else
                c1 = combo[0]
                c2 = combo[1]
              end
              
              # if one slot is playable and the other is playable or owned by us, we play that slot
              if board.valid_move?(c1.to_s) && (board.valid_move?(c2.to_s) || board.cells[c2-1] == self.token)
                return c1.to_s
              elsif board.valid_move?(c2.to_s) && (board.valid_move?(c1.to_s) || board.cells[c1-1] == self.token)
                return c2.to_s
              end
            end
          end
        end
      end
      # if none of those conditions met, we'll play a random piece
      rnd = (1 + rand(9)).to_s
      while !board.valid_move?(rnd)
        rnd = (1 + rand(9)).to_s
      end
      rnd
    end
  end
end
