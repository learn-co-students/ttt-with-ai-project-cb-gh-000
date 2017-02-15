class Board

  attr_accessor :cells

  WIN_COMBOS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize
    reset!
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    @cells.each_with_index do |cell, i|
      if i % 3 == 0
        puts " #{@cells[i]} | #{@cells[i+1]} | #{@cells[i+2]} "
        if !i.eql?(6)
          puts "-----------"
        end
      end
    end
  end

  def position(input)
    @cells[input.to_i - 1]
  end

  def full?
    turn_count.eql?(9)
  end

  def turn_count
    @cells.map{ |cell| !cell.eql?(" ") ? cell : nil }.compact.size
  end

  def taken?(input)
    !position(input).eql?(" ")
  end

  def valid_move?(input)
    (input.to_i - 1 < 9) && (input.to_i - 1 >= 0) && !taken?(input)
  end

  def update(input, player)
    if valid_move?(input)
      @cells[input.to_i - 1] = player.token
      true
    else
      puts "#{input} is invalid"
      false
    end
  end
end
