# stores methods for Knight class

require_relative 'piece'

class Knight < Piece
  def moves
    [ 
      [-1, 2],
      [-1, -2],
      [1, 2],
      [1, -2],
      [-2, 1],
      [-2, -1],
      [2, 1],
      [2, -1]
    ]
  end

  def unicode
    "\u265E"
  end
end
