module Players
  class Human < Player

    def move(board)
      print "Player #{self.token} >>> "
      gets
    end

  end
end
