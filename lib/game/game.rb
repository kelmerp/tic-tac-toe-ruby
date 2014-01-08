require_relative 'board'
require_relative 'ui'

class Game

  PLAYERS = [:computer, :human]

  attr_reader :first_player, :computer_mark, :human_mark
  attr_accessor :board, :current_player, :ui

  def initialize(args = {})
    @board = Board.new(:board_size => args[:board_size])
    @winning_lines = get_winning_lines
    @first_player = get_random_player
    @current_player = @first_player
    @computer_mark = get_computer_mark
    @human_mark = get_human_mark
    @winner = false
    @ui = UI.new
  end

  def get_winning_lines
    rows = [[0,1,2],[3,4,5],[6,7,8]]
    columns = [[0,3,6],[1,4,7],[2,5,8]]
    diagonals = [[0,4,8],[2,4,6]]

    rows + columns + diagonals
  end

  def get_random_player
    PLAYERS.sample
  end

  def play
    until over?
      UI.display(board, computer_mark, human_mark, current_player)
      UI.print_first_player(@first_player) if first_turn?

      if current_player == :computer
        puts "Executing computer move"
        sleep 2
        computer_move
      else
        human_move
      end
    end
    UI.display(board, computer_mark, human_mark, current_player)
    get_winner
    UI.show_winner(@winner)
  end

  def over?
    winner? || board.full?
  end

  def winner?
    @winning_lines.each do |a, b, c|
      return true if board.content[a] == board.content[b] && 
      board.content[b] == board.content[c] && 
      board.content[a] != ""
    end
    false
  end

  def get_winner
    @winning_lines.each do |a, b, c|
      if board.content[a] == board.content[b] &&
       board.content[b] == board.content[c] && board.content[a] != ""
        @winner = board.content[a]
      end
    end

    if @winner == "x"
      @winner = first_player
    elsif @winner == "o"
      @winner = second_player
    end
  end

  def get_computer_mark
    if first_player == :computer
      "x"
    else
      "o"
    end
  end

  def get_human_mark
    if first_player == :human
      "x"
    else
      "o"
    end
  end

  def computer_move
    h = human_mark
    next_move = false

    if next_move = winning_move #returns index of winning move or false
      board.mark(next_move, computer_mark)
    elsif next_move = blocking_move #returns index of blocking move or false
      board.mark(next_move, computer_mark)
    else
      board.mark(best_move, computer_mark)
    end

    next_player
  end

  def winning_move
    @winning_lines.each do |a, b, c|
      if @board.content[a] == computer_mark && @board.content[b] == computer_mark && @board.content[c] == ""
        return c
      elsif @board.content[b] == computer_mark && @board.content[c] == computer_mark && @board.content[a] == ""
        return a
      elsif @board.content[a] == computer_mark && @board.content[c] == computer_mark && @board.content[b] == ""
        return b
      end
    end
    false
  end

  def blocking_move
    @winning_lines.each do |a, b, c|
      if @board.content[a] == human_mark && @board.content[b] == human_mark && @board.content[c] == ""
        return c
      elsif @board.content[b] == human_mark && @board.content[c] == human_mark && @board.content[a] == ""
        return a
      elsif @board.content[a] == human_mark && @board.content[c] == human_mark && @board.content[b] == ""
        return b
      end
    end
    false
  end

  def best_move
    h = human_mark
    c = computer_mark

    if first_player == :computer && board.content[0] == ""
      0
    elsif first_player == :human  && board.content[4] == ""
      4
    elsif first_player == :computer && board.content[4] == ""
      4
    elsif board.content[0] == c && board.content[4] == h && board.content[8] == ""
      8
    elsif board.content[0] == h && board.content[8] == h && board.content[1] == ""
      1
    elsif board.content[2] == h && board.content[6] == h && board.content[1] == ""
      1
    elsif board.content[0] == c && board.content[4] == c && board.content[1] == h && board.content[6] == ""
      6
    elsif board.content[4] == h && board.content[8] == h && board.content[2] == ""
      2
    elsif board.content[0] == h && board.content[7] == h && board.content[6] == ""
      6    
    elsif board.content[6] == h && board.content[5] == h && board.content[8] == ""
      8    
    elsif board.content[8] == h && board.content[1] == h && board.content[2] == ""
      2    
    elsif board.content[2] == h && board.content[3] == h && board.content[0] == ""
      0
    elsif board.content[1] == h && board.content[6] == h && board.content[0] == ""
      0 
    elsif board.content[3] == h && board.content[8] == h && board.content[6] == ""
      6   
    elsif board.content[7] == h && board.content[2] == h && board.content[8] == ""
      8
    elsif board.content[5] == h && board.content[0] == h && board.content[2] == ""
      2
    else
      board.content.index("")
    end
  end

  # def human_move
  #   begin
  #     puts "type the number where you want to place your marker or q to quit"
  #     print ">"
  #     input = gets.strip
  #     exit if input.downcase == "q"
  #     redo unless input.match(/[0-8]/)
  #   end until board.mark(input.to_i, human_mark)
  #   next_player
  # end

  def human_move
    board.mark(UI.human_input(@board), human_mark)
    next_player
  end

  def next_player
    if self.current_player == :human
      self.current_player = :computer
    else
      self.current_player = :human
    end
  end

  def first_turn?
    board.empty?
  end

  def second_player
    (PLAYERS - [first_player]).pop
  end
end
