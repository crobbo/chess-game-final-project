# frozen_string_literal: true
require 'pry'

# Controls the gameplay
class Game
  attr_reader :board, :player1, :player2, :destination_coordinates

  def initialize(player1, player2)
    @board = Board.new(player1, player2).place_pieces
    @player_one = player1
    @player_two = player2
    @current_square = nil
    @destination_square = nil
    @current_square_coordinates = [] 
    @destination_coordinates = []
  end

  def play
    puts 'Player 1:'
    @player_one.ask_name
    puts "\nPlayer 2: "
    @player_two.ask_name
    puts "#{who_plays_first} GOES FIRST!"

    until checkmate?
      move_piece
      @current_square = nil
      @destination_square = nil
    end
  end

  def move_piece
    puts "Select piece to move:"
    @current_square = obtain_current_square
    puts "Select square to move to:"
    @destination_square = obtain_destination_square
    binding.pry
    if @current_square.which_player == whos_turn && @destination_square == ''
      binding.pry
      if @current_square.valid_move?(@current_square_coordinates, @destination_coordinates)
        @destination_square = @current_square
        @current_square = ''
      end 
    elsif @current_square.which_player && @destination_square.which_player != whos_turn
      if @current_square.valid_move?(@current_square_coordinates, @destination_coordinates)
      end
    end
  end

  def who_plays_first
    arr = [@player_one.player[:name], @player_two.player[:name]]
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
    if @player_one.player[:name] == name
      @player_one.player[:next_turn] = true
    else
      @player_two.player[:next_turn] = true
    end
    name.upcase
  end
  
  def obtain_current_square
    puts 'Enter X coordinate:'
    x = user_input
    puts 'Enter Y coordinate:'
    y = user_input
    @current_square_coordinates << x
    @current_square_coordinates << y
    @board[8-y][x-1]
  end

  def obtain_destination_square
    puts 'Enter X coordinate:'
    x = user_input
    puts 'Enter Y coordinate:'
    y = user_input
    @destination_coordinates << (x)
    @destination_coordinates << (y)
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
    @player_one.player[:next_turn] ? @player_one : @player_two
  end

  def continue
    print "press any key to continue.."
    STDIN.getch
    print "            \r"
  end
end