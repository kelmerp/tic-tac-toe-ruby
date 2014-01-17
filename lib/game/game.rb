require_relative 'board'
require_relative 'ui'
require_relative 'rules'
require_relative 'player'

class Game

  attr_reader :first_player, :computer_mark, :human_mark, :current_player, :board

  def initialize(args = {})
    @board = Board.new(:board_size => args[:board_size])
    @rules = Rules.new(:board => board)
    @players = Player.generate_players(:ai_level => args[:ai_level])
    @winning_lines = @rules.get_winning_lines
    @first_player = @players.sample
    @current_player = @first_player
    @computer_mark = get_computer_mark
    @human_mark = get_human_mark
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
    UI.output_message("Executing computer move")
    sleep 2
    position_to_mark = current_player.ai.get_move(@winning_lines, board, computer_mark, human_mark, first_player)
    board.mark(position_to_mark, computer_mark)
    next_player
  end

  def human_move
    board.mark(UI.human_input(@board), human_mark)
    next_player
  end

  def next_player
    @current_player = (@players - [self.current_player]).pop
  end

  def first_turn?
    board.empty?
  end

  def set_winner(mark)
    if mark == @computer_mark
      @winner = :computer
    elsif mark == @human_mark
      @winner = :human
    end
  end
end
