
class Players
  
  class Human < Player
    
    def move(board)
      puts "input from 1-9"
      gets.strip
    end 
    
  end
  
end

# learn spec/03_human_player_spec.rb --fail-fast
