class Players
  class Human < Player

      def move(board)
        puts "What move do you wanna make?"
        input = gets.strip
      end

  end
end
