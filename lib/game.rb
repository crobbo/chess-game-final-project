# frozen_string_literal: true

# Controls the gameplay
class Game
  attr_reader :board, :player_one, :player_two

  def initialize()
    @start_game = Board.new
    @board = @start_game.new_board
    @player_one = Player.new
    @player_two = Player.new
  end
 
  def play
    puts 'Player 1:'
    @player_one.ask_name
    puts "\nPlayer 2: "
    @player_two.ask_name
    puts "#{who_plays_first} GOES FIRST!"
    until checkmate?
      # game loops until checkmate
    end
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
    return arr.sample.upcase
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

  def valid_piece?
    # checks that chess peice belongs to user
  end

end
