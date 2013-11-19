class TicTacToe

  PLAYERS = [:computer, :human]

  attr_reader :first_player, :computer_mark, :human_mark
  attr_accessor :board, :winner, :current_player

  def initialize
    @board = ["","","","","","","","",""]
    @first_player = get_random_player
    @current_player = @first_player
    @computer_mark = get_computer_mark
    @human_mark = get_human_mark
    @winner = false
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

  def get_computer_mark
    if @first_player == :computer
      "x"
    else
      "o"
    end
  end

  def get_human_mark
    if @first_player == :human
      "x"
    else
      "o"
    end
  end

  def display
    system("clear")
    puts "Tic-Tac Toe"
    puts "-----------"
    puts "computer player is #{@computer_mark}"
    puts "you are #{@human_mark}"
    puts "-----"
    puts self
    puts "-----"
  end
end