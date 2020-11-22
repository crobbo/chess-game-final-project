require 'tty-table'
require_relative 'game'
# require_relative 'board'
require_relative 'player'


new_game = Game.new(Player.new(1), Player.new(2))
new_game.play