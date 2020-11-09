# stores methods for Pawn class

require_relative 'lib/pieces'

class Pawn < Pieces
  def moves
    [
      [1, 1],
      [0, 1],
      [-1, 1]
    ]
  end

  def unicode
    "\u265F"
  end
end
