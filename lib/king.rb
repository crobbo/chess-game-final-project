# stores methods for King class

require_relative 'piece'

class King < Piece
  def moves
    [
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0],
      [-1, -1],
      [0, -1],
      [1, -1],
      [1, 0]
    ]
  end

  def unicode
    "\u265A"
  end

end
