require 'tty-table'

# Builds chess board and places pieces in their correct starting position

class Board
  attr_reader 

  def initialize()
    @board = [
      %|. . . . . . . . |,
      %|. . . . . . . . |,
      %|. . . . . . . . |,
      %|. . . . . . . . |,
      %|. . . . . . . . |,
      %|. . . . . . . . |,
      %|. . . . . . . . |,
      %|. . . . . . . . |
    ]

  #   @player_one = [ 
  #     @pawn_one = {valid: true, coordinates: [1, 7], unicode: "\u265F", type: 'pawn'},
  #     @pawn_two = {valid: true, coordinates: [2, 7], unicode: "\u265F", type: 'pawn'},
  #     @pawn_three = {valid: true, coordinates: [3, 7], unicode: "\u265F", type: 'pawn'},
  #     @pawn_four = {valid: true, coordinates: [4, 7], unicode: "\u265F", type: 'pawn'},
  #     @pawn_five = {valid: true, coordinates: [5, 7], unicode: "\u265F", type: 'pawn'},
  #     @pawn_six = {valid: true, coordinates: [6, 7], unicode: "\u265F", type: 'pawn'},
  #     @pawn_seven = {valid: true, coordinates: [7, 7], unicode: "\u265F", type: 'pawn'},
  #     @pawn_eight = {valid: true, coordinates: [8, 7], unicode: "\u265F", type: 'pawn'},
  #     @rook_one = {valid: true, coordinates: [1, 8], unicode:"\u265C", type: 'rook'},
  #     @knight_one = {valid: true, coordinates: [2, 8], unicode: "\u265E", type: 'knight'},
  #     @bishop_one = {valid: true, coordinates: [3, 8], unicode:"\u265D", type: 'bishop'},
  #     @king = {valid: true, coordinates: [4, 8], unicode: "\u265A", type: 'king'},
  #     @queen = {valid: true, coordinates: [5, 8], unicode: "\u265B", type: 'queen'},
  #     @bishop_two = {valid: true, coordinates: [6, 8], unicode:"\u265D", type: 'bishop'},
  #     @knight_two = {valid: true, coordinates: [7, 8], unicode: "\u265E", type: 'knight'},
  #     @rook_two = {valid: true, coordinates: [8, 8], unicode:"\u265C", type: 'rook'}
  #   ]

  #   @player_two = [ 
  #     @pawn_one = {valid: true, coordinates: [1, 2], unicode: "\u2659", type: 'pawn'},
  #     @pawn_two = {valid: true, coordinates: [2, 2], unicode: "\u2659", type: 'pawn'},
  #     @pawn_three = {valid: true, coordinates: [3, 2], unicode: "\u2659", type: 'pawn'},
  #     @pawn_four = {valid: true, coordinates: [4, 2], unicode: "\u2659", type: 'pawn'},
  #     @pawn_five = {valid: true, coordinates: [5, 2], unicode: "\u2659", type: 'pawn'},
  #     @pawn_six = {valid: true, coordinates: [6, 2], unicode: "\u2659", type: 'pawn'},
  #     @pawn_seven = {valid: true, coordinates: [7, 2], unicode: "\u2659", type: 'pawn'},
  #     @pawn_eight = {valid: true, coordinates: [8, 2], unicode: "\u2659", type: 'pawn'},
  #     @rook_one = {valid: true, coordinates: [1, 1], unicode: "\u2656", type: 'rook'},
  #     @knight_one = {valid: true, coordinates: [2, 1], unicode: "\u2658", type: 'knight'},
  #     @bishop_one = {valid: true, coordinates: [3, 1], unicode: "\u2657", type: 'bishop'},
  #     @king = {valid: true, coordinates: [4, 1], unicode: "\u2654", type: 'king'},
  #     @queen = {valid: true, coordinates: [5, 1], unicode: "\u2655", type: 'queen'},
  #     @bishop_two = {valid: true, coordinates: [6, 1], unicode: "\u2657", type: 'bishop'},
  #     @knight_two = {valid: true, coordinates: [7, 1], unicode: "\u2658", type: 'knight'},
  #     @rook_two = {valid: true, coordinates: [8, 1], unicode: "\u2656", type: 'rook'}
  #   ]
  #   @new_board = setup()
  # end

  # def setup
  #   table = TTY::Table.new do |t|
  #     t << ["8", "", "", "", "", "", "", "", ""]
  #     t << ["7", "", "", "", "", "", "", "", ""]
  #     t << ["6", "", "", "", "", "", "", "", ""]
  #     t << ["5", "", "", "", "", "", "", "", ""]
  #     t << ["4", "", "", "", "", "", "", "", ""]
  #     t << ["3", "", "", "", "", "", "", "", ""]
  #     t << ["2", "", "", "", "", "", "", "", ""]
  #     t << ["1", "", "", "", "", "", "", "", ""]
  #     t << ["", "1", "2", "3", "4", "5", "6", "7", "8"]
  #   end
  #   player_one[0..7].each_with_index do |v, index|
  #       table[1][index+1] << player_one[index][:unicode]
  #   end
  #   player_one[8..15].each_with_index do |v, index|
  #     table[0][index+1] << player_one[8 + index][:unicode]
  #   end

  #   player_two[0..7].each_with_index do |v, index|
  #       table[6][index+1] << player_two[index][:unicode]
  #   end
  #   player_two[8..15].each_with_index do |v, index|
  #     table[7][index+1] << player_two[8 + index][:unicode]
  #   end
  #   return table
  # end

end