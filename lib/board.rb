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
  attr_reader :board, :start_coordinates, :start_square, :finish_coordinates, :finish_square

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2

    @start_square = nil
    @finish_square = nil
    @start_coordinates = []
    @finish_coordinates = []

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

  def board_pretty_print
    # table = TTY::Table.new do |t|
      # t << ["8", board[0][0].unicode, board[0][1].unicode, board[0][2].unicode, board[0][3].unicode, board[0][4].unicode, board[0][5].unicode, board[0][6].unicode, board[0][7].unicode]
      # t << ["7", board[1][0].unicode, board[1][1].unicode, board[1][2].unicode, board[1][3].unicode, board[1][4].unicode, board[1][5].unicode, board[1][6].unicode, board[1][7].unicode]
      # t << ["6", board[2][0].unicode, board[2][1].unicode, board[2][2].unicode, board[2][3].unicode, board[2][4].unicode, board[2][5].unicode, board[2][6].unicode, board[2][7].unicode]
      # t << ["5", board[3][0].unicode, board[3][1].unicode, board[3][2].unicode, board[3][3].unicode, board[3][4].unicode, board[3][5].unicode, board[3][6].unicode, board[3][7].unicode]
      # t << ["4", board[4][0].unicode, board[4][1].unicode, board[4][2].unicode, board[4][3].unicode, board[4][4].unicode, board[4][5].unicode, board[4][6].unicode, board[4][7].unicode]
      # t << ["3", board[5][0].unicode, board[5][1].unicode, board[5][2].unicode, board[5][3].unicode, board[5][4].unicode, board[5][5].unicode, board[5][6].unicode, board[5][7].unicode]
      # t << ["2", board[6][0].unicode, board[6][1].unicode, board[6][2].unicode, board[6][3].unicode, board[6][4].unicode, board[6][5].unicode, board[6][6].unicode, board[6][7].unicode]
      # t << ["1", board[7][0].unicode, board[7][1].unicode, board[7][2].unicode, board[7][3].unicode, board[7][4].unicode, board[7][5].unicode, board[7][6].unicode, board[7][7].unicode]
      # t << ["-", "1", "2", "3", "4", "5", "6", "7", "8"]
      # end 

      table = TTY::Table.new do |t|
        t << ["8", convert_to_print(0, 0), convert_to_print(0, 1), convert_to_print(0, 2), convert_to_print(0, 3), convert_to_print(0, 4), convert_to_print(0, 5), convert_to_print(0, 6), convert_to_print(0, 7)] 
        t << ["7", convert_to_print(1, 0), convert_to_print(1, 1), convert_to_print(1, 2), convert_to_print(1, 3), convert_to_print(1, 4), convert_to_print(1, 5), convert_to_print(1, 6), convert_to_print(1, 7)] 
        t << ["6", convert_to_print(2, 0), convert_to_print(2, 1), convert_to_print(2, 2), convert_to_print(2, 3), convert_to_print(2, 4), convert_to_print(2, 5), convert_to_print(2, 6), convert_to_print(2, 7)] 
        t << ["5", convert_to_print(3, 0), convert_to_print(3, 1), convert_to_print(3, 2), convert_to_print(3, 3), convert_to_print(3, 4), convert_to_print(3, 5), convert_to_print(3, 6), convert_to_print(3, 7)] 
        t << ["4", convert_to_print(4, 0), convert_to_print(4, 1), convert_to_print(4, 2), convert_to_print(4, 3), convert_to_print(4, 4), convert_to_print(4, 5), convert_to_print(4, 6), convert_to_print(4, 7)] 
        t << ["3", convert_to_print(5, 0), convert_to_print(5, 1), convert_to_print(5, 2), convert_to_print(5, 3), convert_to_print(5, 4), convert_to_print(5, 5), convert_to_print(5, 6), convert_to_print(5, 7)] 
        t << ["2", convert_to_print(6, 0), convert_to_print(6, 1), convert_to_print(6, 2), convert_to_print(6, 3), convert_to_print(6, 4), convert_to_print(6, 5), convert_to_print(6, 6), convert_to_print(6, 7)] 
        t << ["1", convert_to_print(7, 0), convert_to_print(7, 1), convert_to_print(7, 2), convert_to_print(7, 3), convert_to_print(7, 4), convert_to_print(7, 5), convert_to_print(7, 6), convert_to_print(7, 7)] 
        t << ["-", "1", "2", "3", "4", "5", "6", "7", "8"]
        end 

      puts table.render(:ascii)
  end

  def convert_to_print(a, b)
    if board[a][b] == ""
      return ""
    else
      return board[a][b].unicode
    end
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

  def choose_coordinates
    puts 'Select piece to move:'
    @start_square = obtain_start_square
    puts 'Select square to move to:'
    @finish_square = obtain_finish_square
  end

  def obtain_start_square
    puts 'Enter X coordinate:'
    x = user_input
    puts 'Enter Y coordinate:'
    y = user_input
    @start_coordinates << x
    @start_coordinates << y
    @board[8-y][x-1]
  end

  def obtain_finish_square
    puts 'Enter X coordinate:'
    x = user_input
    puts 'Enter Y coordinate:'
    y = user_input
    @finish_coordinates << (x)
    @finish_coordinates << (y)
    @board[8-y][x-1]
  end

  def user_input
    num = loop do
      num = Integer(gets) rescue nil
      break num if num && num < 9 && num > 0

      puts "you didn't enter a valid number..."
    end
    return num
  end

  def reset_variables
    @start_square = nil
    @finish_square = nil
    @start_coordinates = []
    @finish_coordinates = []
  end

end
