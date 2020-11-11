# stores methods for Pawn class

require_relative 'piece'
require_relative 'game'
require_relative 'board'

class Pawn < Piece

  def moves
    [
      [1, 1],
      [0, 1],
      [-1, 1]
    ]
  end

  def valid_move?(start_coordinates, destination_coordinates)
    # [0,1] will always be a valid move unless piece in fron belongs to the same player. 
    binding.pry
  end

  def unicode
    "\u265F"
  end
end
