# stores methods for Rook class

require_relative 'piece'
require 'pry'

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
  
    if squares.include?(finish_coordinates) && space_between? 
    end


  end

  def space_between?(start_coordinates, finish_coordinates)
  end


  def possible_moves(start_coordinates) 
    moves = []
    row = find_row_squares(start_coordinates)
    column = find_column_squares(start_coordinates)
    moves << row
    moves << column
    moves
  end

  def find_row_squares(start_coordinates)
    arr = []
    i = 1
    until i > 8
      arr << [i, start_coordinates[1]]
      i += 1
    end
    arr.delete(start_coordinates)
    arr
  end
  
  def find_column_squares(start_coordinates)
    arr = []
    j = 1
    until j > 8
      arr << [start_coordinates[0], j]
      j += 1
    end
    arr.delete(start_coordinates)
    arr
  end

end
