require 'tty-table'
require_relative 'game'
require_relative 'board'
require_relative 'player'
require_relative 'piece_properties'

new_game = Game.new
puts new_game.print_board
new_game.player_two.player[:next_turn] = true
new_game.select_piece