# stores methods for King class

require_relative 'piece'
require 'pry'

class King < Piece
  def moves
    [
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0],
      [-1, -1],
      [0, -1],
      [1, -1],
      [1, 0]
    ]
  end

  def valid_move?(start_coordinates, finish_coordinates, board, player)
    sqaures = possible_moves(start_coordinates)
    # If finish square is empty, returns true or false whether piece can move there
    if board[8 - finish_coordinates[1]][finish_coordinates[0] - 1] == ''
      if sqaures.include?(finish_coordinates)
        true
      end
    # # If finish square contains opponents piece return true
    elsif board[8 - finish_coordinates[1]][finish_coordinates[0] - 1].which_player != player
      if sqaures.include?(finish_coordinates)
        true
      end
    # If finish square contains own players piece then return false. 
    elsif board[8 - finish_coordinates[1]][finish_coordinates[0] - 1].which_player == player
      binding.pry
      false
    end
  end
  # returns a nested array of coordinates which are possible moves
  def possible_moves(start_coordinates)
    coordinates = []
    moves.each do |i|
      arr = [start_coordinates]
      arr << i
      coordinates << arr.transpose.map(&:sum)
    end
    coordinates
  end

  def unicode
    "\u265A"
  end

end

