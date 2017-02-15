module Players

  WIN_COMBOS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  class Human < Player
    def move(board = [])
      input = gets
      input.chomp
    end
  end

  class Computer < Player

    def initialize(token = "X")
      super
      @game_state = GameState.new(Array.new(9))
      GameTree.new.generate(@game_state, "X", @token)
    end

    def move(board)
      new_board = board.is_a?(Board) ? board.cells.dup : board.dup
      if new_board.map{|e| e.eql?(" ") ? nil : e}.compact.size > 0
        check_board = new_board.map{|e| e.eql?(" ") ? nil : e}
        @game_state = @game_state.children.detect{|e| e.board.eql?(check_board)}
      end
      @game_state = @game_state.children.max{|a, b| a.rank <=> b.rank}
      (@game_state.last_move[:index] + 1).to_s
    end

  end

  class GameState
    attr_accessor :children, :board, :last_move, :own_token

    def initialize(board)
      @board = board
      @children = []
    end

    def is_over?
      is_won? || is_draw?
    end

    def is_won?
      WIN_COMBOS.any? do |combo|
        @board[combo[0]].eql?(@board[combo[1]]) && @board[combo[1]].eql?(@board[combo[2]]) && !@board[combo[0]].nil?
      end
    end

    def is_draw?
      !is_won? && @board.compact.size.eql?(9)
    end

    def winner
      WIN_COMBOS.each do |combo|
        if @board[combo[0]].eql?(@board[combo[1]]) && @board[combo[1]].eql?(@board[combo[2]]) && !@board[combo[0]].nil?
          return @board[combo[0]]
        end
      end
    end

    def rank
      @rank ||= final_state_rank || intermediate_state_rank
    end

    def final_state_rank
      if is_over?
        return 0 if is_draw?
        winner.eql?(@own_token) ? 10 : -10
      end
    end

    def intermediate_state_rank
      ranks = @children.collect{ |game_state| game_state.rank }
      if !@last_move[:token].eql?(@own_token)
        ranks.max
      else
        ranks.min
      end
    end
  end

  class GameTree
    def generate(current_game_state, current_player, own_token)
      next_player = current_player.eql?("X") ? "O" : "X"
      current_game_state.board.each_with_index do |x, y|
        if x.nil?
          next_board = current_game_state.board.dup
          next_board[y] = current_player
          next_game_state = GameState.new(next_board)
          next_game_state.last_move = {:index => y, :token => current_player}
          next_game_state.own_token = own_token

          current_game_state.children << next_game_state
          generate(next_game_state, next_player, own_token)
        end
      end
    end
  end
end
