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
    return false unless same_axis?(chess.start_coordinates, chess.finish_coordinates)

    squares = possible_moves(chess.start_coordinates)
    if (squares[0].include?(chess.finish_coordinates) || squares[1].include?(chess.finish_coordinates)) && (space_between_column?(chess) || space_between_row?(chess))
      if chess.finish_square == ''
        true
      elsif chess.finish_square.which_player != player
        true
      elsif chess.finish_square.which_player == player
        false
      else
        false
      end
    else
      false
    end
  end

  def same_axis?(start_coordinates, finish_coordinates)
    if start_coordinates[0] == finish_coordinates[0]
      true
    elsif start_coordinates[1] == finish_coordinates[1]
      true
    else
      false
    end
  end

  def space_between_column?(chess)
    return false unless chess.start_coordinates[0] == chess.finish_coordinates[0]

    row = transpose_column(chess)
    row.index(chess.start_square) < row.index(chess.finish_square) ? row : row = row.reverse
    start = row.index(chess.start_square) + 1
    finish = row.index(chess.finish_square) - 1
    result = row[start..finish].each do |x|
      return false if x != ''
      break if x != ''
    end
    result == false ? false : true
  end

  def transpose_column(chess)
    transposed_board = chess.board.transpose 
    transposed_board[chess.start_coordinates[0]- 1]
  end

  def space_between_row?(chess)
    return false unless chess.start_coordinates[1] == chess.finish_coordinates[1]

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
