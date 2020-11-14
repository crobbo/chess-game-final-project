class Errors
  def invalid_move
    puts "This is a not a valid move. Try again:"
  end

  def wrong_piece
    puts "The square you chose does not contain your piece. Try again:"
  end
end