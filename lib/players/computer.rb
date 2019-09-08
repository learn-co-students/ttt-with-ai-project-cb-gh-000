
class Players 
  
  class Computer < Player
    
    def move(board)
      ["1", "2", "3", "4", "5", "6", "7", "8", "9"].sample
    end
    
  end
  
end



# learn spec/05_computer_player_spec.rb --fail-fast