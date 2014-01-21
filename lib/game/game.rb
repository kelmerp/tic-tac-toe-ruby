require_relative 'board'
require_relative 'ui'
require_relative 'rules'
require_relative 'player'

# require 'debugger'

class Game

  attr_reader :first_player, :second_player, :current_player, :board, :winning_lines, :current_player_opponent

  def initialize(args = {})
    # debugger

    @board = Board.new(:board_size => args[:board_size])
    @rules = Rules.new(:board => board)
    @players = Player.generate_players(args[:players])
    @winning_lines = @rules.get_winning_lines
    @first_player = @players.sample
    @second_player = (@players - [@current_player]).pop
    @current_player = @first_player
    @current_player_opponent = (@players - [@current_player]).pop
    # @first_player_mark = "x"
    # @second_player_mark = "o"
    set_player_marks
  end

  def set_player_marks
    @first_player.mark = "x"
    @second_player.mark = "o"
  end

  # def get_first_player_mark
  #   first_player.mark = "x"
  # end

  # def get_human_mark
  #   first_player.type == :human ? "x" : "o"
  # end

  def play
    until over?
      UI.display(board, first_player, second_player, current_player)
      UI.print_first_player(@first_player) if first_turn?
      current_player.move(self)
      next_player
    end 
    UI.display(board, first_player, second_player, current_player)
    set_winner(@rules.get_winner)
    UI.show_winner(@winner)
  end

  def over?
    @rules.winner? || board.full?
  end

  # def take_turns_playing
  #   @players.each do |player| 
  #     player.move(self)
  #     next_player
  #   end
  # end

  # def computer_move
  #   # UI.output_message("Executing computer move")
  #   # sleep 2
  #   position_to_mark = current_player.ai.get_move(@winning_lines, board, first_player_mark, second_player_mark, first_player)
  #   board.mark(position_to_mark, first_player_mark)
  #   next_player
  # end

  # def human_move
  #   board.mark(UI.human_input(@board), second_player_mark)
  #   next_player
  # end

  def next_player
    @current_player_opponent = @current_player
    @current_player = (@players - [@current_player]).pop
  end

  def first_turn?
    board.empty?
  end

  def set_winner(mark)
    if mark == first_player.mark
      @winner = first_player
    elsif mark == second_player.mark
      @winner = second_player
    end
  end
end
