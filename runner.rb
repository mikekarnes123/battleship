require './lib/game'

game = Game.new
game.menu
game.start_game if game.ready == true