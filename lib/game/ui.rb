require 'debugger'
class UI

  def self.display(board, computer_mark, human_mark, current_player)
    system("clear")
    puts "Tic-Tac Toe"
    puts "-----------"
    puts "computer player is #{computer_mark}"
    puts "you are #{human_mark}"
    puts "-----"
    self.show_board(board)
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
    until input
      puts "type the number where you want to place your marker or q to quit"
      print ">"
      input = gets.strip
      exit if input.downcase == "q"
      redo unless self.valid_input?(input, board)
    end

    input.to_i
  end

  def self.valid_input?(string, board)
    string.match(/[0-#{board.size}]/) && board.content[string.to_i] == ""
  end

  def self.output_message(string)
    puts string
  end

  def self.show_board(board)
    0.upto(board.size ** 2 - 1) do |n|
      if board.content[n] == "x" || board.content[n] == "o"
        print "#{board.content[n]}"
      else
        print "#{n}"
      end

      if ((n + 1) % board.size) == 0
        print "\n"
      else
        print "|"
      end
    end
  end

end