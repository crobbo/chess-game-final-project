# stores methods for Pawn class

require_relative 'piece'
require_relative 'game'
require_relative 'board'
require_relative 'player'
require 'pry'

class Pawn < Piece

  def initialize(player)
    @which_player = super
    @valid = super
    @first_move = true
  end

  def moves
    [
      # player1 moves
      [1,-1],
      [0, -1],
      [0, -2],
      [-1, -1],
      #player 2 moves
      [1, 1],
      [0, 1],
      [0, 2],
      [-1, 1]
    ]
  end

  def valid_move?(chess, player)
    squares = possible_moves(chess.start_coordinates, player)
    if check_forward_moves(chess, player, squares)
      true
    elsif check_diagonal_moves(chess, player)
      true
    else
      false
    end
  end

  def check_diagonal_moves(chess, player, squares)
    if squares[0].inlcude?(chess.finish_coordinates) && chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1] == ''
      false
    elsif squares[0].include?(chess.finish_coordinates) && chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1].which_player == player
      false
    elsif squares[0].include?(chess.finish_coordinates) && chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1].which_player != player
      true
    else
      false
    end
  end
  
  def check_forward_moves(chess, player, squares)
    if squares[1].include?(chess.finish_coordinates) && chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1] == ''
      true
    elsif squares[1].include?(chess.finish_coordinates) && chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1].which_player == player
      false
    elsif squares[1].include?(chess.finish_coordinates) && chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1].which_player != player
      false
    else
      false
    end
  end

  def possible_moves(start_coordinates, player)
    # IMPORTANT: a possible move may not be a valid move. Valid moves method validates if it is a correct move.
   player.data[:number] == 1 ? player_one_moves(start_coordinates) : player_two_moves(start_coordinates)
  end

  def player_one_moves(start_coordinates)
    moves = [[], []]
    route_one = [start_coordinates, self.moves[0]]
    moves[0] << route_one.transpose.map(&:sum)

    route_two = [start_coordinates, self.moves[3]]
    moves[0] << route_two.transpose.map(&:sum)

    route_three = [start_coordinates, self.moves[1]]
    moves[1] << route_three.transpose.map(&:sum)

    if @first_move
      route_four = [start_coordinates, self.moves[2]]
      moves[1] << route_four.transpose.map(&:sum)
    end
    moves
  end

  def player_two_moves(start_coordinates)
    moves = [[], []]
    route_one = [start_coordinates, self.moves[4]]
    moves[0] << route_one.transpose.map(&:sum)

    route_two = [start_coordinates, self.moves[7]]
    moves[0] << route_two.transpose.map(&:sum)

    route_three = [start_coordinates, self.moves[5]]
    moves[1] << route_three.transpose.map(&:sum)

    if @first_move
      route_four = [start_coordinates, self.moves[6]]
      moves[1] << route_four.transpose.map(&:sum)
    end
    moves
  end

  def change_first_move
    @first_move = false
  end

  def unicode
    "\u265F"
  end
end
