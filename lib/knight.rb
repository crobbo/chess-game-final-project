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

  def possible_moves(start_coordinates)
    coordinates = []
    moves.each do |i|
      arr = [start_coordinates]
      arr << i
      coordinates << arr.transpose.map(&:sum)
    end
    coordinates
  end

  def unicode
    "\u265E"
  end
end
