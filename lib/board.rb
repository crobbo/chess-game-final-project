require 'tty-table'
require 'pp'
require_relative 'rook'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'knight'
require_relative 'king'
require_relative 'queen'
require_relative 'player'
require 'colorize'

# Builds chess board and places pieces in their correct starting position
require_relative 'player'

class Board
  attr_reader :board
  attr_accessor :start_coordinates, :finish_coordinates, :start_square, :finish_square

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
    table = TTY::Table.new ["-", "1".yellow, "2".yellow, "3".yellow, "4".yellow, "5".yellow, "6".yellow, "7".yellow, "8".yellow],
                          [:separator, ["8".yellow, convert_to_print(0, 0), convert_to_print(0, 1), convert_to_print(0, 2), convert_to_print(0, 3), convert_to_print(0, 4), convert_to_print(0, 5), convert_to_print(0, 6), convert_to_print(0, 7)], 
                          :separator, ["7".yellow, convert_to_print(1, 0), convert_to_print(1, 1), convert_to_print(1, 2), convert_to_print(1, 3), convert_to_print(1, 4), convert_to_print(1, 5), convert_to_print(1, 6), convert_to_print(1, 7)], 
                          :separator, ["6".yellow, convert_to_print(2, 0), convert_to_print(2, 1), convert_to_print(2, 2), convert_to_print(2, 3), convert_to_print(2, 4), convert_to_print(2, 5), convert_to_print(2, 6), convert_to_print(2, 7)],
                          :separator, ["5".yellow, convert_to_print(3, 0), convert_to_print(3, 1), convert_to_print(3, 2), convert_to_print(3, 3), convert_to_print(3, 4), convert_to_print(3, 5), convert_to_print(3, 6), convert_to_print(3, 7)],
                          :separator, ["4".yellow, convert_to_print(4, 0), convert_to_print(4, 1), convert_to_print(4, 2), convert_to_print(4, 3), convert_to_print(4, 4), convert_to_print(4, 5), convert_to_print(4, 6), convert_to_print(4, 7)],
                          :separator, ["3".yellow, convert_to_print(5, 0), convert_to_print(5, 1), convert_to_print(5, 2), convert_to_print(5, 3), convert_to_print(5, 4), convert_to_print(5, 5), convert_to_print(5, 6), convert_to_print(5, 7)],
                          :separator, ["2".yellow, convert_to_print(6, 0), convert_to_print(6, 1), convert_to_print(6, 2), convert_to_print(6, 3), convert_to_print(6, 4), convert_to_print(6, 5), convert_to_print(6, 6), convert_to_print(6, 7)],
                          :separator, ["1".yellow, convert_to_print(7, 0), convert_to_print(7, 1), convert_to_print(7, 2), convert_to_print(7, 3), convert_to_print(7, 4), convert_to_print(7, 5), convert_to_print(7, 6), convert_to_print(7, 7)],
                          :separator, ["-", "1".yellow, "2".yellow, "3".yellow, "4".yellow, "5".yellow, "6".yellow, "7".yellow, "8".yellow]]

   multi_renderer = TTY::Table::Renderer::ASCII.new(table, multiline: true, alignments: :center, padding: [0, 1, 0, 1], border: {style: :white})
   puts multi_renderer.render
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
    puts 'Select piece to move:'.light_blue
    @start_square = obtain_start_square
    puts 'Select square to move to:'.light_blue
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
    num = Integer(gets)
    if num.positive? && num < 9
      num
    else
      puts "Incorrect input, try again"
      user_input
    end
  end
  

  def reset_variables
    @start_square = nil
    @finish_square = nil
    @start_coordinates = []
    @finish_coordinates = []
  end

end
