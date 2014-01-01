class Game

  PLAYERS = [:computer, :human]

  attr_reader :first_player, :computer_mark, :human_mark
  attr_accessor :board, :current_player

  def initialize
    @board = ["","","","","","","","",""]
    @winning_lines = get_winning_lines
    @first_player = get_random_player
    @current_player = @first_player
    @computer_mark = get_computer_mark
    @human_mark = get_human_mark
    @winner = false
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

  def print_board
    0.upto(8) do |n|
      if board[n] == "x" || board[n] == "o"
        print "#{board[n]}"
      else
        print "#{n}"
      end

      if n == 2 || n == 5 || n == 8
        print "\n"
      else
        print "|"
      end
    end
  end

  def play
    until over?
      display
      print_first_player if first_turn?

      if current_player == :computer
        puts "Executing computer move"
        sleep 2
        computer_move
      else
        human_move
      end
    end
    display
    show_winner
  end

  def over?
    winner? || !board.include?("")
  end

  # def winner?
  #   winner = ""
  #   if (board[0] == board[1] && board[1] == board[2] && board[0] != "") ||
  #     (board[0] == board[4] && board[4] == board[8] && board[0] != "") ||
  #     (board[0] == board[3] && board[3] == board[6] && board[0] != "")
  #       winner = board[0]
  #   elsif (board[1] == board[4] && board[4] == board[7] && board[4] != "") ||
  #     (board[2] == board[4] && board[4] == board[6] && board[4] != "") ||
  #     (board[3] == board[4] && board[4] == board[5] && board[4] != "")
  #       winner = board[4]
  #   elsif (board[6] == board[7] && board[7] == board[8] && board[8] != "") ||
  #     (board[2] == board[5] && board[5] == board[8] && board[8] != "")
  #       winner = board[8]
  #   else #no winner
  #     return false
  #   end

  #   if winner == "x"
  #     winner = first_player
  #   else
  #     winner = (PLAYERS - [first_player]).pop
  #   end
  # end

  def winner?
    @winning_lines.each do |a, b, c|
      return true if board[a] == board[b] && board[b] == board[c] && board[a] != ""
    end
    false
  end

  def get_winner
    @winning_lines.each do |a, b, c|
      if board[a] == board[b] && board[b] == board[c] && board[a] != ""
        @winner = board[a]
      end
    end

    if @winner == "x"
      @winner = first_player
    else
      @winner = (PLAYERS - [first_player]).pop
    end
  end

  def print_first_player
    if first_player == :computer
      puts "Computer gets to go first"
    else
      puts "You get to go first"
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

  def display
    system("clear")
    puts "Tic-Tac Toe"
    puts "-----------"
    puts "computer player is #{computer_mark}"
    puts "you are #{human_mark}"
    puts "-----"
    print_board
    puts "-----"
    puts "Current player: #{current_player}"
  end

  def computer_move
    h = human_mark
    next_move = false

    if next_move = winning_move #returns index of winning move or false
      mark_board(next_move)
    elsif next_move = blocking_move #returns index of blocking move or false
      mark_board(next_move)
    else
      mark_board(best_move)
    end

    next_player
  end

  def winning_move
    c = computer_mark
    c_marks = []

    board.each_with_index { |square, i| c_marks << i if square == c }

    if c_marks.include?(0) && c_marks.include?(1) && board[2] == ""
      2
    elsif c_marks.include?(0) && c_marks.include?(2) && board[1] == ""
      1
    elsif c_marks.include?(1) && c_marks.include?(2) && board[0] == ""
      0
    elsif c_marks.include?(3) && c_marks.include?(4) && board[5] == ""
      5
    elsif c_marks.include?(3) && c_marks.include?(5) && board[4] == ""
      4
    elsif c_marks.include?(4) && c_marks.include?(5) && board[3] == ""
      3
    elsif c_marks.include?(6) && c_marks.include?(7) && board[8] == ""
      8
    elsif c_marks.include?(6) && c_marks.include?(8) && board[7] == ""
      7
    elsif c_marks.include?(7) && c_marks.include?(8) && board[6] == ""
      6
    elsif c_marks.include?(0) && c_marks.include?(3) && board[6] == ""
      6
    elsif c_marks.include?(0) && c_marks.include?(6) && board[3] == ""
      3
    elsif c_marks.include?(3) && c_marks.include?(6) && board[0] == ""
      0
    elsif c_marks.include?(1) && c_marks.include?(4) && board[7] == ""
      7
    elsif c_marks.include?(1) && c_marks.include?(7) && board[4] == ""
      4
    elsif c_marks.include?(4) && c_marks.include?(7) && board[1] == ""
      1
    elsif c_marks.include?(2) && c_marks.include?(5) && board[8] == ""
      8
    elsif c_marks.include?(2) && c_marks.include?(8) && board[5] == ""
      5
    elsif c_marks.include?(5) && c_marks.include?(8) && board[2] == ""
      2
    elsif c_marks.include?(0) && c_marks.include?(4) && board[8] == ""
      8
    elsif c_marks.include?(0) && c_marks.include?(8) && board[4] == ""
      4
    elsif c_marks.include?(4) && c_marks.include?(8) && board[0] == ""
      0
    elsif c_marks.include?(2) && c_marks.include?(4) && board[6] == ""
      6
    elsif c_marks.include?(2) && c_marks.include?(6) && board[4] == ""
      4
    elsif c_marks.include?(4) && c_marks.include?(6) && board[2] == ""
      2
    else
      false
    end
  end

  def blocking_move
    h = human_mark
    h_marks = []

    board.each_with_index { |square, i| h_marks << i if square == h }
    
    if h_marks.include?(0) && h_marks.include?(1) && board[2] == ""
      2
    elsif h_marks.include?(0) && h_marks.include?(2) && board[1] == ""
      1
    elsif h_marks.include?(1) && h_marks.include?(2) && board[0] == "" 
      0
    elsif h_marks.include?(3) && h_marks.include?(4) && board[5] == ""
      5
    elsif h_marks.include?(3) && h_marks.include?(5) && board[4] == ""
      4
    elsif h_marks.include?(4) && h_marks.include?(5) && board[3] == ""
      3
    elsif h_marks.include?(6) && h_marks.include?(7) && board[8] == ""
      8
    elsif h_marks.include?(6) && h_marks.include?(8) && board[7] == ""
      7
    elsif h_marks.include?(7) && h_marks.include?(8) && board[6] == ""
      6
    elsif h_marks.include?(0) && h_marks.include?(3) && board[6] == ""
      6
    elsif h_marks.include?(0) && h_marks.include?(6) && board[3] == ""
      3
    elsif h_marks.include?(3) && h_marks.include?(6) && board[0] == ""
      0
    elsif h_marks.include?(1) && h_marks.include?(4) && board[7] == ""
      7
    elsif h_marks.include?(1) && h_marks.include?(7) && board[4] == ""
      4
    elsif h_marks.include?(4) && h_marks.include?(7) && board[1] == ""
      1
    elsif h_marks.include?(2) && h_marks.include?(5) && board[8] == ""
      8
    elsif h_marks.include?(2) && h_marks.include?(8) && board[5] == ""
      5
    elsif h_marks.include?(5) && h_marks.include?(8) && board[2] == ""
      2
    elsif h_marks.include?(0) && h_marks.include?(4) && board[8] == ""
      8
    elsif h_marks.include?(0) && h_marks.include?(8) && board[4] == ""
      4
    elsif h_marks.include?(4) && h_marks.include?(8) && board[0] == ""
      0
    elsif h_marks.include?(2) && h_marks.include?(4) && board[6] == ""
      6
    elsif h_marks.include?(2) && h_marks.include?(6) && board[4] == ""
      4
    elsif h_marks.include?(4) && h_marks.include?(6) && board[2] == ""
      2
    else
      false
    end
  end

  def best_move
    h = human_mark
    c = computer_mark

    if first_player == :computer && board[0] == ""
      0
    elsif first_player == :human  && board[4] == ""
      4
    elsif first_player == :computer && board[4] == ""
      4
    elsif board[0] == c && board[4] == h && board[8] == ""
      8
    elsif board[0] == h && board[8] == h && board[1] == ""
      1
    elsif board[2] == h && board[6] == h && board[1] == ""
      1
    elsif board[0] == c && board[4] == c && board[1] == h && board[6] == ""
      6
    elsif board[4] == h && board[8] == h && board[2] == ""
      2
    elsif board[0] == h && board[7] == h && board[6] == ""
      6    
    elsif board[6] == h && board[5] == h && board[8] == ""
      8    
    elsif board[8] == h && board[1] == h && board[2] == ""
      2    
    elsif board[2] == h && board[3] == h && board[0] == ""
      0
    elsif board[1] == h && board[6] == h && board[0] == ""
      0 
    elsif board[3] == h && board[8] == h && board[6] == ""
      6   
    elsif board[7] == h && board[2] == h && board[8] == ""
      8
    elsif board[5] == h && board[0] == h && board[2] == ""
      2
    else
      board.index("")
    end
  end

  def mark_board(index)
    if board[index] != ""
      false
    elsif current_player == first_player
      board[index] = "x"
      true
    else
      board[index] = "o"
      true
    end
  end

  def human_move
    begin
      puts "type the number where you want to place your marker or q to quit"
      print ">"
      input = gets.strip
      exit if input.downcase == "q"
      redo unless input.match(/[0-8]/)
    end until mark_board(input.to_i)
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
    board == ["","","","","","","","",""]
  end

  def show_winner
    get_winner
    if @winner
      puts "#{winner} is the winner"
    else
      puts "The game is a tie"
    end
  end
end
