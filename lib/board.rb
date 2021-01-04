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
    #   t << ["8", board[0][0], board[0][1], board[0][2], board[0][3], board[0][4], board[0][5], board[0][6], board[0][7]]
    #   t << ["7", board[1][0], board[1][1], board[1][2], board[1][3], board[1][4], board[1][5], board[1][6], board[1][7]]
    #   t << ["6", board[2][0], board[2][1], board[2][2], board[2][3], board[2][4], board[2][5], board[2][6], board[2][7]]
    #   t << ["5", board[3][0], board[3][1], board[3][2], board[3][3], board[3][4], board[3][5], board[3][6], board[3][7]]
    #   t << ["4", board[4][0], board[4][1], board[4][2], board[4][3], board[4][4], board[4][5], board[4][6], board[4][7]]
    #   t << ["3", board[5][0], board[5][1], board[5][2], board[5][3], board[5][4], board[5][5], board[5][6], board[5][7]]
    #   t << ["2", board[6][0], board[6][1], board[6][2], board[6][3], board[6][4], board[6][5], board[6][6], board[6][7]]
    #   t << ["1", board[7][0], board[7][1], board[7][2], board[7][3], board[7][4], board[7][5], board[7][6], board[7][7]]
    #   t << ["-", "1", "2", "3", "4", "5", "6", "7", "8"]
    #   end 

      table = TTY::Table.new do |t|
        t << ["8", "", "", "", "", "", "", "", ""] 
        t << ["7", "", "", "", "", "", "", "", ""] 
        t << ["6", "", "", "", "", "", "", "", ""] 
        t << ["5", "", "", "", "", "", "", "", ""] 
        t << ["4", "", "", "", "", "", "", "", ""] 
        t << ["3", "", "", "", "", "", "", "", ""] 
        t << ["2", "", "", "", "", "", "", "", ""] 
        t << ["1", "", "", "", "", "", "", "", ""] 
        t << ["-", "1", "2", "3", "4", "5", "6", "7", "8"]
        end 

      puts table.render(:ascii)
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
