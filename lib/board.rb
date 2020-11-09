require 'tty-table'

# Builds chess board and places pieces in their correct starting position

class Board
  attr_reader :board

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
    @player_one = [
    @pawn_one = Pawn.new,
    @pawn_two = Pawn.new,
    @pawn_three = Pawn.new,
    @pawn_four = Pawn.new,
    @pawn_five = Pawn.new,
    @pawn_six = Pawn.new,
    @pawn_seven = Pawn.new,
    @pawn_eight = Pawn.new,
    @rook_one = Rook.new,
    @knight_one = Knight.new,
    @bishop_one = Bishop.new,
    @king = King.new,
    @queen = Queen.new,
    @bishop_two = Bishop.new,
    @knight_two = Knight.new,
    @rook_two = Rook.new
    ]
    @player_two = [
      @pawn_one = Pawn.new,
      @pawn_two = Pawn.new,
      @pawn_three = Pawn.new,
      @pawn_four = Pawn.new,
      @pawn_five = Pawn.new,
      @pawn_six = Pawn.new,
      @pawn_seven = Pawn.new,
      @pawn_eight = Pawn.new,
      @rook_one = Rook.new,
      @knight_one = Knight.new,
      @bishop_one = Bishop.new,
      @king = King.new,
      @queen = Queen.new,
      @bishop_two = Bishop.new,
      @knight_two = Knight.new,
      @rook_two = Rook.new
      ]
  end

  def place_pieces
    @board = [
      %|@player_one[8] @player_one[9] @player_one[10] @player_one[11] @player_one[12] @player_one[13] @player_one[14] @player_one[15]|,
      %|@player_one[0] @player_one[1] @player_one[2] @player_one[3] @player_one[4] @player_one[5] @player_one[6] @player_one[7]|,
      %|. . . . . . . . |,
      %|. . . . . . . . |,
      %|. . . . . . . . |,
      %|. . . . . . . . |,
      %|@player_two[0] @player_two[1] @player_two[2] @player_two[3] @player_two[4] @player_two[5] @player_two[6] @player_two|,
      %|@player_two[8] @player_two[9] @player_two[10] @player_two[12] @player_two[11] @player_two[13] @player_two[14] @player_two[15]
    ]
end