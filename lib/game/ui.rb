class UI

  def self.display(board, computer_mark, human_mark, current_player)
    system("clear")
    puts "Tic-Tac Toe"
    puts "-----------"
    puts "computer player is #{computer_mark}"
    puts "you are #{human_mark}"
    puts "-----"
    board.show
    puts "-----"
    puts "Current player: #{current_player}"
  end

  def self.print_first_player(first_player)
    if first_player == :computer
      puts "Computer gets to go first"
    else
      puts "You get to go first"
    end
  end

  def self.show_winner(winner)
    if winner
      puts "#{winner} is the winner"
    else
      puts "The game is a tie"
    end
  end

  def self.human_input(board)
    input = false
    begin
      puts "type the number where you want to place your marker or q to quit"
      print ">"
      input = gets.strip
      exit if input.downcase == "q"
      redo unless input.match(/[0-8]/) || board.content[input.to_i] != ""
    end until input

    input.to_i
  end

end