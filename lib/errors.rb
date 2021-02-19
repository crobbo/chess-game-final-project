require 'colorize'

class Errors
  attr_reader :invalid_move, :which_piece

  def invalid_move
    puts '    TRY AGAIN, this is a not a valid move!'.light_red
  end

  def wrong_piece
    puts 'TRY AGAIN, the square you chose does not contain your piece!'.light_red
  end

  def invalid_castle
    puts '    TRY AGAIN, castle move not valid!'.light_red
  end
end