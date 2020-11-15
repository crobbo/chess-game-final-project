# frozen_string_literal: true
require_relative 'board'
require_relative 'errors'

# Controls the gameplay
class Game
  attr_accessor :board, :player_one, :player_one, :start_square, :finish_square, :start_coordinates, :finish_coordinates, :error

  def initialize(player1, player2)
    @board = Board.new(player1, player2).place_pieces
    @player_one = player1
    @player_two = player2
    @start_square = nil
    @finish_square = nil
    @start_coordinates = []
    @finish_coordinates = []
    @error = Errors.new
  end

  def play
    puts 'Player 1:'
    @player_one.ask_name
    puts "\nPlayer 2: "
    @player_two.ask_name
    puts "#{who_plays_first} GOES FIRST!"

    until checkmate?
      unless move_piece
        @error.invalid_move
        move_piece
      end
      reset_variables
    end
  end

  def move_piece
    puts 'Select piece to move:'
    @start_square = obtain_start_square
    puts 'Select square to move to:'
    @finish_square = obtain_finish_square

    return false unless @start_square.which_player == whos_turn
    return false unless @start_square.valid_move?(@start_coordinates, @finish_coordinates, @board, whos_turn)

    if @board[8 - @start_coordinates[1]][@start_coordinates[0] - 1] == ''
      nil
    else
      @start_square.which_player.graveyard << @board[8 - @start_coordinates[1]][@start_coordinates[0] - 1]
    end

    @board[8 - @finish_coordinates[1]][@finish_coordinates[0] - 1] = @start_square
    @board[8 - @start_coordinates[1]][@start_coordinates[0] - 1] = ''
  end

  def who_plays_first
    arr = [@player_one.data[:name], @player_two.data[:name]]
    # sleep 2
    puts "Computer will randomly select the first player..."
    # sleep 2
    puts "Building random selection machine"
    # sleep 2
    puts 'Adding magic sauce'
    # sleep 2
    puts 'Initiating start up'
    # sleep 4
    name = arr.sample
    if @player_one.data[:name] == name
      @player_one.data[:next_turn] = true
    else
      @player_two.data[:next_turn] = true
    end
    name.upcase
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

  def checkmate?
  end

  def check?
  end

  def print_board
    # method to print TTY Table board
  end

  def whos_turn
    @player_one.data[:next_turn] ? @player_one : @player_two
  end

  def reset_variables
    @start_square = nil
    @finish_square = nil
    @start_coordinates = []
    @finish_coordinates = []
  end

  def continue
    print "press any key to continue.."
    STDIN.getch
    print "            \r"
  end
end