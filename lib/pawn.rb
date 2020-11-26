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

    squares = possible_moves(chess.board, player)

    

  end

  def possible_moves(start_coordinates, player)
    # IMPORTANT: a possible move may not be a valid move. Valid moves method validates if it is a correct move.
   player.data[:number] == 1 ? player_one_moves : player_two_moves
  end

  def player_one_moves
    moves = [[], []]
    route_one = [start_coordinates, self.moves[0]]
    moves[0] << route_one.transpose.map(&:sum)

    route_two = [start_coordinates, self.moves[3]]
    moves[0] << route_two.transpose.map(&:sum)

    route_three = [start_coordinates, self.moves[1]]
    moves[1] << route_three.transpose.map(&:sum)

    if first_move
      route_four = [start_coordinates, self.moves[2]]
      moves[1] << route_two.transpose.map(&:sum)
    end
    moves
  end

  def player_two_moves
    moves = [[], []]
    route_one = [start_coordinates, self.moves[4]]
    moves[0] << route_one.transpose.map(&:sum)

    route_two = [start_coordinates, self.moves[7]]
    moves[0] << route_two.transpose.map(&:sum)

    route_three = [start_coordinates, self.moves[5]]
    moves[1] << route_three.transpose.map(&:sum)

    if first_move
      route_four = [start_coordinates, self.moves[6]]
      moves[1] << route_two.transpose.map(&:sum)
    end
    moves
  end

  def first_move
    @first_move
  end

  def unicode
    "\u265F"
  end
end
