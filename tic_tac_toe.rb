class TicTacToe

  PLAYERS = [:computer, :human]

  attr_reader :current_player, :first_player
  attr_accessor :board, :winner

  def initialize
    @board = ["","","","","","","","",""]
    @first_player = get_random_player
    @current_player = @first_player
  end

  def get_random_player
    PLAYERS.sample
  end

  def to_s
    string = ""

    0.upto(8) do |n|
      if @board[n] == "x" || @board[n] == "o"
        string += "#{@board[n]}"
      else
        string += "#{n}"
      end

      if n == 2 || n == 5 || n == 8
        string += "\n"
      else
        string += "|"
      end
    end
    string
  end

  def over?
    winner? || !@board.include?("")
  end

  def winner?
    winner = ""
    if (@board[0] == @board[1] && @board[1] == @board[2] && @board[0] != "") ||
      (@board[0] == @board[4] && @board[4] == @board[8] && @board[0] != "") ||
      (@board[0] == @board[3] && @board[3] == @board[6] && @board[0] != "")
        winner = @board[0]
    elsif (@board[1] == @board[4] && @board[4] == @board[7] && @board[4] != "") ||
      (@board[2] == @board[4] && @board[4] == @board[6] && @board[4] != "") ||
      (@board[3] == @board[4] && @board[4] == @board[5] && @board[4] != "")
        winner = @board[4]
    elsif (@board[6] == @board[7] && @board[7] == @board[8] && @board[8] != "") ||
      (@board[2] == @board[5] && @board[5] == @board[8] && @board[8] != "")
        winner = @board[8]
    else #no winner
      return false
    end

    if winner == "x"
      self.winner = self.first_player
    else
      self.winner = (PLAYERS - [self.first_player]).pop
    end
  end
end