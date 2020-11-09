# stores methods for Rook class

require_relative 'lib/pieces'

class Rook < Pieces
  def moves
   # Rooks can move anywhere vertically or horizontally
  end

  def unicode
    "\u265C"
  end
end
