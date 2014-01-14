require_relative 'board'
require_relative 'ui'
require_relative 'rules'
require_relative 'player'
require_relative 'ai'

class Game

  attr_reader :first_player, :computer_mark, :human_mark, :ai
  attr_accessor :board, :current_player, :ui

  def initialize(args = {})
    @board = Board.new(:board_size => args[:board_size])
    @rules = Rules.new(:board => board)
    @players = Player.generate_players.shuffle!
    @ai = get_ai(args[:ai_level])
    @winning_lines = @rules.get_winning_lines
    @first_player = @players.first
    @current_player = @first_player
    @computer_mark = get_computer_mark
    @human_mark = get_human_mark
    @winner = false
  end

  def get_ai(ai_level = :medium)
    if ai_level == nil || :medium
      ProceduralAI.new
    end
  end

  def get_computer_mark
    first_player.type == :computer ? "x" : "o"
  end

  def get_human_mark
    first_player.type == :human ? "x" : "o"
  end

  def play
    until over?
      UI.display(board, computer_mark, human_mark, current_player)
      UI.print_first_player(@first_player) if first_turn?

      if current_player.type == :computer
        UI.output_message("Executing computer move")
        sleep 2
        computer_move
      else
        human_move
      end
    end
    UI.display(board, computer_mark, human_mark, current_player)
    set_winner(@rules.get_winner)
    UI.show_winner(@winner)
  end

  def over?
    @rules.winner? || board.full?
  end

  def computer_move
    position_to_mark = ai.get_move(@winning_lines, board, computer_mark, human_mark, first_player)
    board.mark(position_to_mark, computer_mark)
    next_player
  end

  def human_move
    board.mark(UI.human_input(@board), human_mark)
    next_player
  end

  def next_player
    self.current_player = (@players - [self.current_player]).pop
  end

  def first_turn?
    board.empty?
  end

  def second_player
    (PLAYERS - [first_player]).pop
  end

  def set_winner(mark)
    if mark == @computer_mark
      @winner = :computer
    elsif mark == @human_mark
      @winner = :human
    end
  end
end
