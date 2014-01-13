class Player
  attr_reader :type

  def self.generate_players
    players = []

    players << Player.new(:type => :computer)
    players << Player.new(:type => :human)

    players
  end

  def initialize(args = {})
    @type = args[:type]
  end
end