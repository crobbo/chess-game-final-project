# stores methods for Bishop class

require_relative 'piece'
require 'pry'

class Bishop < Piece

  def moves
    # bishop move diagonal so could be many diferent squares that it could move to
  end

  def valid_move?(chess, player)
  end

  def possible_moves(chess)
    find_diagonals(chess)
    find_antediagonals(chess)
  end

  def find_diagonals(chess)
    arr = []
    coordinates = chess.start_coordinates
    arr << diag_bottom_left(coordinates)
    arr << diag_top_right(coordinates)
    arr
  end

  def diag_bottom_left(coordinates)
    arr = []
    loop do
      coordinates[0] = coordinates[0] - 1
      coordinates[1] = coordinates[1] - 1
      break if coordinates.include?(0) || coordinates.include?(9)

      arr << [coordinates[0], coordinates[1]]
    end
    arr
  end

  def diag_top_right(coordinates)
    arr = []
    loop do
      coordinates[0] = coordinates[0] + 1
      coordinates[1] = coordinates[1] + 1
      break if coordinates.include?(0) || coordinates.include?(9)

      arr << [coordinates[0], coordinates[1]]
    end
    arr
  end

  def find_antediagonals(chess)
    arr = []
    coordinates = chess.start_coordinates
    arr << diag_bottom_right(coordinates)
    arr << diag_top_left(coordinates)
    arr
  end

  def diag_top_left(coordinates)
    arr = []
    loop do
      coordinates[0] = coordinates[0] - 1
      coordinates[1] = coordinates[1] + 1
      break if coordinates.include?(0) || coordinates.include?(9)

      arr << [coordinates[0], coordinates[1]]
    end
    arr
  end

  def diag_bottom_right(coordinates)
    arr = []
    loop do
      coordinates[0] = coordinates[0] + 1
      coordinates[1] = coordinates[1] - 1
      break if coordinates.include?(0) || coordinates.include?(9)

      arr << [coordinates[0], coordinates[1]]
    end
    arr
  end

  def space_between_antediagonals
  end

  def space_between_diagonals
  end

  def unicode
    "\u265D"
  end

end