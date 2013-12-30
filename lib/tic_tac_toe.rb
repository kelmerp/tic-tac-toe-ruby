require_relative './game/game'

play_again = true

while play_again
  game = Game.new
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