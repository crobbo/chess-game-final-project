require 'tty-table'
require_relative 'game'
require_relative 'board'
require_relative 'player'


new_game = Game.new(Player.new, Player.new)
p new_game.play