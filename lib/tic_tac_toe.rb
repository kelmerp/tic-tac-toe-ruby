require_relative './game/game'

play_again = true

while play_again
  puts "Welcome to Tic-Tac-Toe"
  puts "----------------------"

  puts "Will Player 1 be a human or computer player?"
  puts " (enter 'h' for human or 'c' for computer)"
  print ">"
  player1_type = gets.strip
  if player1_type == 'c'
    puts "Set computer AI to easy or hard?"
    puts " (enter 'e' for easy or 'h' for hard)"
    print ">"
    player1_ai = gets.strip
  end

  puts "Will Player 2 be a human or computer player?"
  puts " (enter 'h' for human and 'c' for computer)"
  print ">"
  player2_type = gets.strip
  if player2_type == 'c'
    puts "Set computer AI to easy or hard?"
    puts " (enter 'e' for easy or 'h' for hard)"
    print ">"
    player2_ai = gets.strip
  end

  players = {:player1 => {:type => player1_type, :ai_level => player1_ai},
              :player2 => {:type => player2_type, :ai_level => player2_ai}}

 
  game = Game.new(:players => players)
  game.play
  puts "Would you like to play again? (y or n)"
  print ">"
  answer = gets.chomp
  if answer == 'y'
    play_again = true
  else
    play_again = false
  end
end