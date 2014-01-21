require_relative 'board'
require_relative 'ui'
require_relative 'rules'
require_relative 'player'

class Game

  attr_reader :first_player, :second_player, :current_player, :board, :winning_lines, :current_player_opponent

  def initialize(args = {})
    @board = Board.new(:board_size => args[:board_size])
    @rules = Rules.new(:board => board)
    @players = Player.generate_players(args[:players])
    @winning_lines = @rules.get_winning_lines
    @first_player = @players.sample
    @second_player = (@players - [@first_player]).pop
    @current_player = @first_player
    @current_player_opponent = @second_player
  end

  def play
    until over?
      UI.display(board, first_player, second_player, current_player)
      UI.print_first_player(@first_player) if first_turn?
      current_player.move(self)
      next_player
    end 
    UI.display(board, first_player, second_player, current_player)
    set_winner(@rules.get_winner(first_player, second_player))
    UI.show_winner(@winner)
  end

  def over?
    @rules.winner?(first_player, second_player) || board.full?
  end

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