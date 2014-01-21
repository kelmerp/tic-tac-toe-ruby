require_relative 'ai'

class Player
  attr_accessor :mark
  attr_reader :name

  def self.generate_players(players)
    players_array = []

    players.each_key do |player|
      if players[player][:type] == 'c'
        players_array << ComputerPlayer.new(:ai_level => players[player][:ai_level], :name => players[player][:name], :mark => players[player][:mark])
      else
        players_array << HumanPlayer.new(:name => players[player][:name], :mark => players[player][:mark])
      end  
    end

    players_array
  end
end

class ComputerPlayer < Player
  attr_reader :ai

  def initialize(args = {})
    @ai = AI.generate(args[:ai_level])
    @name = args[:name]
    @mark = args[:mark]
  end

  def move(args)
    position_to_mark = ai.get_move(args)
    args[:board].mark(position_to_mark, args[:current_player].mark)
  end
end

class HumanPlayer < Player
  def initialize(args = {})
    @name = args[:name]
    @mark = args[:mark]
  end

  def move(args)
    position_to_mark = UI.human_input(args[:board])
    args[:board].mark(position_to_mark, args[:current_player].mark)
  end
end