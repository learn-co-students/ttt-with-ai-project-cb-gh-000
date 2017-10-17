require 'pry'

class Test

  attr_accessor :board

  def initialize
    @board = Array.new(9, " ")
  end

  def over?
    !self.board.include?(" ")
  end

end

t = Test.new
binding.pry