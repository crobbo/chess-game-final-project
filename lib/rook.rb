# stores methods for Rook class

require_relative 'piece'

class Rook < Piece
  def moves
   # Rooks can move anywhere vertically or horizontally
  end

  def unicode
    "\u265C"
  end
end
