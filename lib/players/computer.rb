module Players
  class Computer < Player
    def move board
      "#{Random.new.rand(1..9)}"
    end
  end
end
