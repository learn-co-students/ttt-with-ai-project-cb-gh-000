class Player
  attr_reader :token

  @@all = []

  def self.all
    @@all
  end

  def initialize(token)
    @token = token
    @@all << self
  end
end
