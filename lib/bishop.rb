# stores methods for Bishop class

require_relative 'piece'
require 'pry'

class Bishop < Piece

  def moves
    # bishop move diagonal so could be many diferent squares that it could move to
  end

  def valid_move?(chess, player)
  end

  def possible_moves
    find_digaonals
    find_antediagonals
  end

  def find_diagonals(chess)
    arr = []
    right_coordinates = chess.start_coordinates
    left_coordinates = chess.start_coordinates
    arr << diag_left_loop(left_coordinates)
    arr << diag_right_loop(right_coordinates)
    arr
  end

  def diag_left_loop(left_coordinates)
    arr = []
    loop do
      left_coordinates[0] = left_coordinates[0] - 1
      left_coordinates[1] = left_coordinates[1] - 1
      break if left_coordinates.include?(0) || left_coordinates.include?(9)

      arr << [left_coordinates[0], left_coordinates[1]]
    end
    arr
  end

  def diag_right_loop(right_coordinates)
    arr = []
    loop do
      right_coordinates[0] = right_coordinates[0] + 1
      right_coordinates[1] = right_coordinates[1] + 1
      break if right_coordinates.include?(0) || right_coordinates.include?(9)

      arr << [right_coordinates[0], right_coordinates[1]]
    end
    arr
  end

  def find_antediagonals
  end

  def space_between_antediagonals
  end

  def space_between_diagonals
  end

  def unicode
    "\u265D"
  end

end