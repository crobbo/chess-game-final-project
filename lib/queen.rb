# stores methods for Queen class

require_relative 'lib/pieces'

class Queen < Pieces
  def moves
    # Queen can move anywhere on the board.
  end

  def unicode
    "\u265B"
  end

end
