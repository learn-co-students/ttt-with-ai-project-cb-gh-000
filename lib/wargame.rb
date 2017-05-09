class Wargame < Game

  @@winners = []

  def initialize
    @player_1 = Players::Computer.new('X', WIN_COMBINATIONS)
    @player_2 = Players::Computer.new('O', WIN_COMBINATIONS)

    @board = Board.new
  end

  def play
    100.times do
      super
      @@winners << winner
      @board.reset!
    end
    results
  end

  def results
    x_won = 0
    o_won = 0

    @@winners.each do |winner|
      if winner == 'X'
        x_won += 1
      else
        o_won += 1
      end
    end

    puts "Out of 100 games, X won #{x_won} times, O won #{o_won} times, and there were #{100 - x_won - o_won} draws."
  end

end