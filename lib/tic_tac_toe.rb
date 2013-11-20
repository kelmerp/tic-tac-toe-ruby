require_relative './game/game'

game = Game.new

begin 
  game.display
  if game.first_turn?
    if game.first_player == :computer
      puts "Computer gets to go first"
      sleep 2
      game.computer_move
    else
      puts "You get to go first"
      game.get_user_input
    end
  else
    puts "Current player: #{game.current_player}"

    if game.current_player == :computer
      puts "Executing computer move"
      sleep 2
      game.computer_move
    else
      game.get_user_input
    end
  end
end until game.over?

game.display
if game.winner
  puts "#{game.winner} is the winner"
else
  puts "The game is a tie"
end