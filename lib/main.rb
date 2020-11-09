require 'tty-table'
require_relative 'game'
require_relative 'board'
require_relative 'player'


new_game = Game.new
puts new_game.print_board
new_game.play