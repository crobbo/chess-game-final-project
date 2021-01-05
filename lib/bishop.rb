# stores methods for Bishop class

require_relative 'piece'
require 'pry'

class Bishop < Piece

  def initialize(player)
    @which_player = super
    @type = 'Bishop'
    @valid = super
  end

  def valid_move?(chess, player)
    squares = possible_moves(chess)
    binding.pry
    if squares[0][0].include?(chess.finish_coordinates)
      if space_between_diagonals?(chess, squares[0]) && chess.finish_square == ''
        return true
      elsif space_between_diagonals?(chess, squares[0]) && chess.finish_square.which_player != player
        return true
      elsif space_between_diagonals?(chess, squares[0]) && chess.finish_square.which_player == player
        return false
      else
        return false
      end
    elsif squares[1][0].include?(chess.finish_coordinates)
      if space_between_diagonals?(chess, squares[1]) && chess.finish_square == ''
        return true
      elsif space_between_antediagonals?(chess, squares[1]) && chess.finish_square.which_player != player
        return true
      elsif space_between_antediagonals?(chess, squares[1]) && chess.finish_square.which_player == player
        return false
      else
        return false
      end
    else
      return false
    end
  end

  def possible_moves(chess)
    arr = []
    arr << find_diagonals(chess)
    arr << find_antediagonals(chess)
    arr
  end

  def find_diagonals(chess)
    arr = []
    left_coordinates = chess.start_coordinates.map(&:clone)
    right_coordinates = chess.start_coordinates.map(&:clone)
    arr << diag_bottom_left(left_coordinates)
    arr << diag_top_right(right_coordinates)
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
    left_coordinates = chess.start_coordinates.map(&:clone)
    right_coordinates = chess.start_coordinates.map(&:clone)
    arr << diag_top_left(left_coordinates)
    arr << diag_bottom_right(right_coordinates)
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
    if self.which_player.data[:number] == 1
      "\u265D"
    else
      "\u2657"
    end
  end
end