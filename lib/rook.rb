# stores methods for Rook class

require_relative 'piece'

class Rook < Piece
  def moves
   # Rooks can move anywhere vertically or horizontally
  end

  def unicode
    "\u265C"
  end

  def valid_move?(chess, player)
    start_coordinates = chess.start_coordinates
    finish_coordinates = chess.finish_coordinates
    
    squares = possible_moves(start_coordinates)
  
    if squares.includes
      

  end

  def possible_moves(start_coordinates) 

    until i > 8
      i = 1
      moves[0] << [start_coordinates[1], i]
      i += 1
    end

    until i > 8 
      i = 1
      moves[1] << [start_coordinates[0], i]
      i += 1
    end

  end

  

end
