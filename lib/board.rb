require 'tty-table'
require 'pp'
require_relative 'rook'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'knight'
require_relative 'king'
require_relative 'queen'
require_relative 'player'

# Builds chess board and places pieces in their correct starting position
require_relative 'player'

class Board
  attr_reader :board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2

    @board = [
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '']
    ]
  end

  def place_pieces
    @board = [
      [Rook.new(@player1), Knight.new(@player1), Bishop.new(@player1), Queen.new(@player1), King.new(@player1), Bishop.new(@player1), Knight.new(@player1), Rook.new(@player1)],
      [Pawn.new(@player1), Pawn.new(@player1), Pawn.new(@player1), Pawn.new(@player1), Pawn.new(@player1), Pawn.new(@player1), Pawn.new(@player1), Pawn.new(@player1)],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      [Pawn.new(@player2), Pawn.new(@player2), Pawn.new(@player2), Pawn.new(@player2), Pawn.new(@player2), Pawn.new(@player2), Pawn.new(@player2), Pawn.new(@player2)],
      [Rook.new(@player2), Knight.new(@player2), Bishop.new(@player2), King.new(@player2), Queen.new(@player2), Bishop.new(@player2), Knight.new(@player2), Rook.new(@player2)]
    ]
  end

end
