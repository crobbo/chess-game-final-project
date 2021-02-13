# stores methods for Knight class

require_relative 'piece'

class Knight < Piece
  attr_reader :type, :valid
  def initialize(player)
    @which_player = player
    @type = 'Knight'
    @valid = true
  end

  def moves
    [ 
      [-1, 2],
      [-1, -2],
      [1, 2],
      [1, -2],
      [-2, 1],
      [-2, -1],
      [2, 1],
      [2, -1]
    ]
  end

  def valid_move?(chess, player)
    squares = possible_moves(chess.start_coordinates)
    if squares.include?(chess.finish_coordinates) && chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1] == ''
      true
    elsif squares.include?(chess.finish_coordinates) && chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1].which_player != player
      true
    elsif squares.include?(chess.finish_coordinates) && chess.board[8 - chess.finish_coordinates[1]][chess.finish_coordinates[0] - 1].which_player == player 
      false
    else
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

  def unicode
    if self.which_player.data[:number] == 1
      "\e[92m\u265E"
    else
      "\e[30m\u265E"
    end
  end
end
