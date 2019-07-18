require 'pry'
module Players
  class Computer < Player

    attr_reader :name

    def name=(name)
      @name = name
    end

    def move(board)
      "#{rand(1..9)}"
    end

  end
end
