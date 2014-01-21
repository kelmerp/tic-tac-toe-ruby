require_relative 'ai'

class Player
  attr_accessor :mark
  attr_reader :name

  def self.generate_players(players)
    players_array = []

    players.each_key do |player|
      if players[player][:type] == 'c'
        players_array << ComputerPlayer.new(:ai_level => players[player][:ai_level], :name => players[player][:name])
      else
        players_array << HumanPlayer.new(:name => players[player][:name])
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
  end

  def move(game_state)
    position_to_mark = ai.get_move(game_state)
    game_state.board.mark(position_to_mark, game_state.current_player.mark)
  end
end

class HumanPlayer < Player
  def initialize(args = {})
    @name = args[:name]
  end

  def move(game_state)
    position_to_mark = UI.human_input(game_state.board)
    game_state.board.mark(position_to_mark, game_state.current_player.mark)
  end
end