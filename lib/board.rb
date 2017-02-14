class Board

  attr_accessor :cells, :rank, :last_move

  WIN_COMBOS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize
    self.reset!
    @last_move = {}
  end

  def reset!
    @cells = Array.new(9, " ")
  end
  
  def rank(player)
    @rank ||= final_state_rank(player) || intermediate_state_rank(player)
  end

  def final_state_rank(player)
    if final_state?
      return 0 if draw?
      winner == player.token ? 1 : -1
    end
  end

  def intermediate_state_rank(player)
    ranks = player.options.collect{ |board| board.rank(player)}
    if current_player == player.token
      ranks.max
    else
      ranks.min
    end
  end

  def current_player
    @cells.map{|cell| cell.eql?(" ") ? nil : cell}.compact.size.even? ? "X" : "O"
  end

  def final_state?
    winner || draw?
  end

  def draw?
    @cells.map{|cell| cell == " " ? nil : cell}.compact.size == 9 && winner.nil?
  end

  def winner
    WIN_COMBOS.collect{|combo|
      (@cells[combo[0]] == @cells[combo[1]] &&
       @cells[combo[1]] == @cells[combo[2]] &&
       @cells[combo[0]] != " ") || nil
    }.compact.first
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(input)
    @cells[input.to_i - 1]
  end

  def full?
    @cells.each do |cell|
      if cell.eql?(" ")
        return false
      end
    end
    true
  end

  def turn_count
    cells = []
    @cells.each do |cell|
      if !cell.eql?(" ")
        cells.push(cell)
      end
    end
    cells.size
  end

  def taken?(input)
    !position(input).eql?(" ") ? true : false
  end

  def valid_move?(input)
    if input.to_i - 1 < 0 or input.to_i - 1 > 8
      return false
    elsif !taken?(input)
      return true
    end
    false
  end

  def update(input, player)
    if valid_move?(input)
      @cells[input.to_i - 1] = player.token
      true
    else
      false
    end
  end
end
