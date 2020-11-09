# stores methods for King class

require_relative 'lib/pieces'

class King < Pieces
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
