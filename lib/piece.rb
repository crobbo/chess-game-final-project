# Store piece properties



class Piece
  attr_reader :which_player, :valid, :moves, :unicode

  def initialize(player)
    @which_player = player
    @valid = true
  end

  def valid_move?(start_coordinates, destination_coordinates, board, player)
    raise NotImplementedError
  end

  def moves
    raise NotImplementedError
  end

  def unicode
    raise NotImplementedError
  end

end
