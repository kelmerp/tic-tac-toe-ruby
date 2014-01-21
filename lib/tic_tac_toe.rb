require_relative './game/game'

play_again = true

while play_again
  UI.welcome
  players = UI.get_players
  game = Game.new(:players => players)
  game.play
  player_again = UI.play_again?
end