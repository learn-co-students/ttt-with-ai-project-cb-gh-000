class Player

  attr_reader :token

  def initialize(token)
    @token = token
  end

  def other_player_token
    @token == 'X' ? 'O' : 'X'
  end

end
