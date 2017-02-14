module Players

  class Human < Player
    def move(board = [])
      input = gets
      input.chomp
    end
  end

  class Computer < Player

    attr_accessor :options

    WIN_COMBOS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    def initialize(token)
      super
      @options = []
      generate_options(Board.new, @token)
    end

    def move(board)
      next_move = @options.max{ |a, b| a.rank(self) <=> b.rank(self) }
      if next_move.last_move[:player] = @token
        (next_move.last_move[:index] + 1).to_s
      elsif next_move.last_move.eql?({})
        (Random.new.rand(8)+1).to_s
      end
    end

    def generate_options(board, current_player)
      next_player = current_player.eql?("X") ? "O" : "X"
      board.cells.map{|cell| cell.eql?(" ") ? nil : cell}.each_with_index do |value, index|
        if value.nil?
          next_board = board.dup
          next_board.cells[index] = current_player
          next_board.last_move = {:index => index, :player => current_player}
          @options << next_board
          generate_options(next_board, next_player)
        end
      end
    end

  end

end
