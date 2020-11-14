# stores methods for Pawn class

require_relative 'piece'
require_relative 'game'
require_relative 'board'
require 'pry'

class Pawn < Piece

  def moves
    [
      # player1 moves
      [1,-1],
      [0, -1],
      [-1, -1],
      #player 2 moves
      [1, 1],
      [0, 1],
      [-1, 1]
    ]
  end

  def valid_move?(start_coordinates, finish_coordinates, board, player)
    if player.data[:number] == 2
      num1 = [start_coordinates, moves[5]]
      diag1 = num1.transpose.map(&:sum)
      num = [start_coordinates, moves[4]]
      forward = num.transpose.map(&:sum)
      num2 = [start_coordinates, moves[3]]
      diag2 = num2.transpose.map(&:sum)
    else
      num1 = [start_coordinates, moves[2]]
      diag1 = num1.transpose.map(&:sum)
      num = [start_coordinates, moves[1]]
      forward = num.transpose.map(&:sum)
      num2 = [start_coordinates, moves[0]]
      diag2 = num2.transpose.map(&:sum)
    end
    # If finish square is empty, returns true or false whether piece can move there
    if board[8 - finish_coordinates[1]][finish_coordinates[0] - 1] == ''
      if finish_coordinates == diag1 || finish_coordinates == diag2
        false
      elsif finish_coordinates == forward
        true
      end
    # # If finish square contains opponents piece return true
    elsif board[8 - finish_coordinates[1]][finish_coordinates[0] - 1].which_player != player
      if finish_coordinates == diag1 || finish_coordinates == diag2
        true
      elsif finish_coordinates == forward
        true
      end
    # If finish square contains own players piece then return false. 
    elsif board[8 - finish_coordinates[1]][finish_coordinates[0] - 1].which_player == player
      false
    end
  end

  def unicode
    "\u265F"
  end
end
