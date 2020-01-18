class Player

  @@all = []

  attr_reader :token

  def initialize(token)
    @token = token
    @@all << self
  end

  def self.all
    @@all
  end

end
