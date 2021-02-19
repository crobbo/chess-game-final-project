# stores methods for King class

require_relative 'piece'
require 'pry'

class King < Piece

  attr_reader :type

  def initialize(player)
    @which_player = player
    @type = 'King'
    @valid = true
    @first_move = true
  end

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

  def valid_move?(chess, player)
    sqaures = possible_moves(chess.start_coordinates)
    if chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1] == ''
      if sqaures.include?(chess.finish_coordinates)
        true
      end
    elsif chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1].which_player != player
      if sqaures.include?(chess.finish_coordinates)
        true
      end
    elsif chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1].which_player == player
      false
    end
  end

  def possible_moves(start_coordinates)
    coordinates = []
    moves.each do |i|
      arr = [start_coordinates]
      arr << i
      coordinates << arr.transpose.map(&:sum)
    end
    coordinates
  end

  def change_first_move
    @first_move = false
  end

  def unicode
    if self.which_player.data[:number] == 1
      "\e[92m\u265A"
    else
      "\e[30m\u265A"
    end
  end
end
