require_relative 'ai'

class Player
  attr_reader :type

  def self.generate_players(args = {})
    players = []

    players << ComputerPlayer.new(:type => :computer, :ai_level => args[:ai_level] )
    players << Player.new(:type => :human)

    players
  end

  def initialize(args = {})
    @type = args[:type]
  end
end

class ComputerPlayer < Player
  attr_reader :ai

  def initialize(args = {})
    @type = args[:type]
    @ai = AI.generate(args[:ai_level])
  end
end