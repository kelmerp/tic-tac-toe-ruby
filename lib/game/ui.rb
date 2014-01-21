class UI
  def self.welcome
    system('clear')
    puts "Welcome to Tic-Tac-Toe"
    puts "----------------------"
  end

  def self.get_players
    puts "Will Player 1 be a human or computer player?"
    puts " (enter 'h' for human or 'c' for computer)"
    print ">"
    player1_type = gets.strip
    if player1_type == 'c'
      puts "Set computer AI to easy or hard?"
      puts " (enter 'e' for easy or 'h' for hard)"
      print ">"
      player1_ai = gets.strip
      player1_name = "Computer Joe"
    else
      puts "What is the name of this player?"
      print ">"
      player1_name = gets.strip
    end
    puts "What mark would you like to use for this player? (traditionally x and o are used)"
    print ">"
    player1_mark = gets.strip

    puts "Will Player 2 be a human or computer player?"
    puts " (enter 'h' for human and 'c' for computer)"
    print ">"
    player2_type = gets.strip
    if player2_type == 'c'
      puts "Set computer AI to easy or hard?"
      puts " (enter 'e' for easy or 'h' for hard)"
      print ">"
      player2_ai = gets.strip
      player2_name = "Computer Jane"
    else
      puts "What is the name of this player?"
      print ">"
      player2_name = gets.strip
    end
    puts "What mark would you like to use for this player? (traditionally x and o are used)"
    print ">"
    player2_mark = gets.strip

    players = {:player1 => {:type => player1_type, :ai_level => player1_ai, :name => player1_name, :mark => player1_mark}, 
              :player2 => {:type => player2_type, :ai_level => player2_ai, :name => player2_name, :mark => player2_mark}}
  end

  def self.display(board, first_player, second_player, current_player)
    system("clear")
    puts "Tic-Tac Toe"
    puts "-----------"
    puts "#{first_player.name} is #{first_player.mark}"
    puts "#{second_player.name} is #{second_player.mark}"
    puts "-----"
    self.show_board(board)
    puts "-----"
    puts "Current player: #{current_player.name}"
  end

  def self.print_first_player(first_player)
    puts "#{first_player.name} goes first."
  end

  def self.show_winner(winner)
    if winner
      puts "#{winner.name} is the winner"
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
    string.match(/[0-#{board.content.size - 1}]/) && board.content[string.to_i] == ""
  end

  def self.output_message(string)
    puts string
  end

  def self.show_board(board)
    0.upto(board.size ** 2 - 1) do |n|
      if board.content[n] == ""
        print "#{n}"
      else
        print "#{board.content[n]}"
      end

      if ((n + 1) % board.size) == 0
        print "\n"
      else
        print "|"
      end
    end
  end

  def self.play_again?
    puts "Would you like to play again? (y or n)"
    print ">"
    answer = gets.chomp
    if answer == 'y'
      true
    else
      false
    end
  end

end