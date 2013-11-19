class TicTacToe

  PLAYERS = [:computer, :human]

  attr_reader :board, :current_player

  def initialize
    @board = ["","","","","","","","",""]
    @first_player = get_random_player
    @current_player = @first_player
  end

  def get_random_player
    PLAYERS.sample
  end
end