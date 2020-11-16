# stores methods for Pawn class

require_relative 'piece'
require_relative 'game'
require_relative 'board'
require_relative 'player'
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
      num1 = [start_coordinates, self.moves[5]]
      diag1 = num1.transpose.map(&:sum)
      num = [start_coordinates, self.moves[4]]
      forward = num.transpose.map(&:sum)
      num2 = [start_coordinates, self.moves[3]]
      diag2 = num2.transpose.map(&:sum)
    else
      num1 = [start_coordinates, self.moves[2]]
      diag1 = num1.transpose.map(&:sum)
      num = [start_coordinates, self.moves[1]]
      forward = num.transpose.map(&:sum)
      num2 = [start_coordinates, self.moves[0]]
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

  def possible_moves(start_coordinates, player)
    # returns a nested array of coordinates of possible moves
    coordinates = []

    if player.data[:number] == 2
      moves.each_with_index do |v, i|
        next if i == 0 || i == 1 || i == 2

        arr = [start_coordinates]
        arr << v
        coordinates << arr.transpose.map(&:sum)
      end
    else
      moves.each_with_index do |v, i|
        next if i == 3 || i == 4 || i == 5
      
        arr = [start_coordinates]
        arr << v
        coordinates << arr.transpose.map(&:sum)
      end
    end
    coordinates
  end

  def unicode
    "\u265F"
  end
end

