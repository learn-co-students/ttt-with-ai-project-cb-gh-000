module Players
	class Human < Player

	  def move(board)
	    puts "What cell do you want to play (1-9) ?"
	    gets.strip
	  end

	end
end
