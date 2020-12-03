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
    squares = possible_moves(chess.start_coordinates)
    if squares.include?(finish_coordinates) && space_between?(chess)
      true
    else
      false
    end
  end
  
  def space_between_column?(chess)
    row = transposed_column(chess)
    start = row[chess.start_square]  
    finish = row[chess.finsih_square]
    result  = row[start..finish].each do |x|
      return false if x != ''
      break if x != ''
    end
    result == false ? false : true
  end

  def transpose_column(chess)
    transposed_board = chess.board.transpose 
    transposed_board[8 - chess.start_coordinates[1]]
  end

  def space_between_row?(chess)
    find_row = chess.board[8 - chess.start_coordinates[1]]
    start = chess.start_coordinates[0]
    finish = chess.finish_coordinates[0] - 2
    find_path = find_row[start..finish]
    result = find_path.each do |x|
      return false if x != ''
      break if x != ''
    end
    result == false ? false : true
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
