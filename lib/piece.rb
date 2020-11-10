# Store piece properties

class Piece
  attr_reader :which_player, :valid, :moves

  def initialize(player)
    @which_player = player
    @valid = true
  end

  def valid_moves
    raise NotImplementedError
  end

  def moves
    raise NotImplementedError
  end

  def unicode
    raise NotImplementedError
  end

end
