module Players

  class Computer < Player
    def move(board = [])
      prng = Random.new
      (prng.rand(8) + 1).to_s
    end
  end
end
