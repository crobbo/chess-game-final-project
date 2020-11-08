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
  end
 
  def play
    puts 'Player 1:'
    @player_one.ask_name
    puts "\nPlayer 2: "
    @player_two.ask_name
    puts "#{who_plays_first} GOES FIRST!"
    binding.pry
    until checkmate?
      # game loops until checkmate
    end
  end

  def move_piece
    # method which moves piece on the board
  end

  def select_piece
    valid_piece?(obtain_coordinates)
  end

  def obtain_coordinates
    coordinates = []
    puts 'Enter X coordinate:'
    coordinates << user_input
    puts 'Enter Y coordinate:'
    coordinates << user_input
  end

  def who_plays_first
    arr = [@player_one.player[:name], @player_two.player[:name]]
    sleep 2
    puts "Computer will randomly select the first player..."
    sleep 2
    puts "Building random selection machine"
    sleep 2
    puts 'Adding magic sauce'
    sleep 2
    puts 'Initiating start up'
    sleep 4
    name = arr.sample
    if @player_one.player[:name] == name
      @player_one.player[:next_turn] = true
    else
      @player_two.player[:next_turn] = true
    end
    name.upcase
  end

  def checkmate?
  end

  def check?
  end

  def print_board
    @board.render(:unicode)
  end

  def valid_move?
    # checks the user inputed values to see if it's a valid chess move
  end

  def valid_piece?(arr)
    which_pieces = whos_turn? ? @pieces_one : @pieces_two

    which_pieces.each do |piece|
      if piece[:coordinates] == arr
        puts true
      end
    end
    nil
  end

  def whos_turn?
    if @player_one.player[:next_turn]
      true
    else
      false
    end
  end

  def continue
    print "press any key to continue.."
    STDIN.getch
    print "            \r"
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