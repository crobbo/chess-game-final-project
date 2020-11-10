# stores methods for Queen class

require_relative 'piece'

class Queen < Piece
  def moves
    # Queen can move anywhere on the board.
  end

  def unicode
    "\u265B"
  end

end
