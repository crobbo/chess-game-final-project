class Errors
  attr_reader :invalid_move, :which_piece

  def invalid_move
    puts 'TRY AGAIN, this is a not a valid move! '
  end

  def wrong_piece
    puts 'TRY AGAIN, the square you chose does not contain your piece!'
  end
end