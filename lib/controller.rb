class Controller

  def call
    input = ''

    puts 'Welcome to Tic-Tac-Toe.'
    print_help

    while input != 'exit' || input != 'n'
      input = gets.strip

      case input
        when 'mode', '1'
          mode
        when 'start', '2'
          start
        when 'help', '3'
          print_help
        else
          puts 'invalid input, enter "help" to get help.'
      end
    end
  end

  def start(player_1=nil, player_2=nil)
    board = Board.new
    game = Game.new(player_1, player_2, board)
    game.play
    play_again(game)
  end

  def mode
    puts 'which mode do you prefer?'
    puts '1. AI VS AI'
    puts '2. Human VS AI'
    puts '3. Human VS Human'

    input = gets.strip
    case input
      when "1"
        player_1 = Players::Computer.new('X')
        player_2 = Players::Computer.new('O')
        start(player_1, player_2)
      when '2'
        player_1 = Players::Human.new('X')
        player_2 = Players::Computer.new('O')
        start(player_1, player_2)
      when '3'
        player_1 = Players::Human.new('X')
        player_2 = Players::Human.new('O')
        start(player_1, player_2)
      else
        puts 'please input 1-3.'

    end
  end

  def print_help
    puts '1. To change player mode, enter "mode".'
    puts '2. To play the game, enter "start".'
    puts '3. To quit, type "exit".'
    puts 'What would you like to do?'
  end

  def play_again(game)
    puts 'Do you want to play again? (Y/n)'
    input = gets

    if input.match(/Y|y|\\n/)
          puts 'segsgsg'
          game.board.reset!
          game.play
    else
      puts 'bye'
      exit 0
    end

  end
end