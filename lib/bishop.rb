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
    arr << diag_top_left(coordinates)
    arr << diag_bottom_right(coordinates)
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

  def space_between_antediagonals?(chess, ante_diags)
    start = chess.start_coordinates
    finish = chess.finish_coordinates
    moves = start[0] < finish[0] ? ante_diags[1] : ante_diags[0]
    bishop_route = moves[0..moves.index(finish)]
    bishop_route.pop
    result = bishop_route.each do |i|
      square = chess.board[8 - i[1]][i[0]- 1]
      return false if square != ''
      break if square != ''
    end
    result == false ? false : true
  end

  def space_between_diagonals?(chess, diags)
    start = chess.start_coordinates
    finish = chess.finish_coordinates
    moves = start[0] < finish[0] ? diags[1] : diags[0]
    bishop_route = moves[0..moves.index(finish)]
    bishop_route.pop
    result = bishop_route.each do |i|
      square = chess.board[8 - i[1]][i[0] - 1]
      return false if square != ''
      break if square != ''
    end
    result == false ? false : true
  end

  def unicode
    "\u265D"
  end
end