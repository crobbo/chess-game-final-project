# frozen_string_literal: true
require 'pry'
# Controls the gameplay

class Game
  attr_reader :board, :player_one, :player_two

  def initialize()
    @start_game = Board.new
    @board = @start_game.new_board

    @pieces_one = @start_game.player_one
    @pieces_two = @start_game.player_two

    @player_one = Player.new
    @player_two = Player.new

    @current_square = nil
    @destination_square = nil
  end

  def play
    puts 'Player 1:'
    @player_one.ask_name
    puts "\nPlayer 2: "
    @player_two.ask_name
    puts "#{who_plays_first} GOES FIRST!"
    # binding.pry
    until checkmate?
      move_piece
      @current_square = nil
      @destination_square = nil
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

  def move_piece
    @current_square = obtain_coordinates
    @destination_square = obtain_coordinates

    if piece_exists?(@current_square) && valid_move?(@current_square)
      # code to move piece on the board.
    
    else
      puts 'Not a valid move! Try again:'
      move_piece
    end
  end

  def piece_exists?(arr)
    which_pieces = (whos_turn? == player_one) ? @pieces_one : @pieces_two
    which_pieces.each do |piece|
      if piece[:coordinates] == arr
        return true
      end
    end
    nil
  end

  def valid_move?
    # can the piece move to this sqaure ?
    # is the square empty and/or can the exisiting poiece be taken 

  end

  def obtain_coordinates
    sleep 2
    puts "\n"
    coordinates = []
    message = @current_square ? select_destination_message : select_piece_message
    puts "#{whos_turn?.player[:name]}, #{message}"
    puts 'Enter X coordinate:'
    coordinates << user_input
    puts 'Enter Y coordinate:'
    coordinates << user_input
  end

  def checkmate?
  end

  def check?
  end

  def print_board
    @board.render(:unicode)
  end

  def whos_turn?
    @player_one.player[:next_turn] ? @player_one : @player_two
  end

  def continue
    print "press any key to continue.."
    STDIN.getch
    print "            \r"
  end

  def select_piece_message
    'which piece do you want to move?'
  end

  def select_destination_message
    'which square do you want to move to?'
  end

  def user_input
    num = loop do
      num = Integer(gets) rescue nil
      break num if num && num < 9 && num > 0

      puts "you didn't enter a valid number..."
    end

    return num 
 end

end