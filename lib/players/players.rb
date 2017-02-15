module Players

  class Human < Player
    def move(board = [])
      input = gets
      input.chomp
    end
  end

  class Computer < Player

    attr_accessor :options, :root_node

    WIN_COMBOS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    def initialize(token)
      super
      @root_node = BoardNode.new(Array.new(9), @token)
      GameTree.new.generate(@root_node)
    end

    def move(board)
      if @token.eql?("X") && @root_node.board.compact.size.eql?(0)
        index = Random.new.rand(8)
        @root_node = @root_node.children[index]
        return (@root_node.last_move[:index] + 1).to_s
      else
        new_board = board.map{|cell| cell.eql?(" ") ? nil : cell}
        @root_node.children.each do |child|
          if child.board.eql?(new_board)
            @root_node = child
          end
        end
        @root_node.children.each{|child| print "#{child.rank} "}
        @root_node = @root_node.children.max{ |a, b| a.rank <=> b.rank }
        return (@root_node.last_move[:index] + 1).to_s
      end
    end

  end

end

class BoardNode

  attr_accessor :board, :children, :last_move, :own_token, :rank, :winner

  WIN_COMBOS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize(board = Array.new(9), own_token = "X", last_move = {:index => nil, :token => nil})
    @board = board
    @children = []
    @own_token = own_token
    @last_move = last_move
  end

  def rank
    @rank ||= final_state_rank || intermediate_state_rank
  end

  def final_state_rank
    if is_won? || is_draw?
      return 0 if is_draw?
      @winner.eql?(@own_token) ? 10 - @children.size : @children.size - 10
    end
  end

  def intermediate_state_rank
    ranks = @children.collect{ |child| child.rank }
    if @last_move[:token] == @own_token
      ranks.max
    else
      ranks.min
    end
  end

  def is_won?
    WIN_COMBOS.any? do |combo|
      if (@board[combo[0]].eql?(@board[combo[1]]) && @board[combo[1]].eql?(@board[combo[2]]) && !@board[combo[0]].nil?)
        @winner = @board[combo[0]]
        true
      else
        false
      end
    end
  end

  def is_draw?
    !is_won? && @board.compact.size.eql?(9)
  end
end

class GameTree
  def generate(current_node, current_player = "X")
    next_player = current_player.eql?("X") ? "O" : "X"
    current_node.board.each_with_index do |cell, index|
      if cell.nil?
        next_node = BoardNode.new(current_node.board.dup, current_node.own_token, { :index => index, :token => current_player })
        next_node.board[index] = current_player
        current_node.children << next_node

        generate(next_node, next_player)
      end
    end
  end
end
