# frozen_string_literal: true
require_relative 'board'
require_relative 'errors'

# Controls the gameplay
class Game
  attr_reader :board

  def initialize(player1, player2)
    @chess = Board.new(player1, player2)
    @player_one = player1
    @player_two = player2
    @error = Errors.new
  end

  def play
    introduction
    until checkmate?
      binding.pry
      valid_move
      @chess.reset_variables
    end
  end

  def introduction
    @chess.place_pieces
    puts 'Player 1:'
    @player_one.ask_name
    puts "\nPlayer 2: "
    @player_two.ask_name
    puts "#{who_plays_first} GOES FIRST!"
  end

  def valid_move
    unless move_piece
      binding.pry
      @error.invalid_move
      move_piece
    end
  end

  def move_piece
    @chess.choose_coordinates
    return false unless @chess.start_square.which_player == whos_turn  # checks player is moving piece which belongs to them
    return false unless @chess.start_square.valid_move?(@chess, whos_turn)

    whos_turn.add_to_graveyard(@chess, @chess.board)
    adjust_board
  end

  def adjust_board
    @chess.board[8 - @chess.finish_coordinates[1]][@chess.finish_coordinates[0] - 1] = @chess.start_square
    @chess.board[8 - @chess.start_coordinates[1]][@chess.start_coordinates[0] - 1] = ''
  end

  def who_plays_first
    # sleep 2
    puts "Computer will randomly select the first player..."
    # sleep 2
    puts "Building random selection machine"
    # sleep 2
    puts 'Adding magic sauce'
    # sleep 2
    puts 'Initiating start up'
    # sleep 4
    arr = [@player_one.data[:name], @player_two.data[:name]]
    name = arr.sample
    if @player_one.data[:name] == name
      @player_one.data[:next_turn] = true
    else
      @player_two.data[:next_turn] = true
    end
    name.upcase
  end

  def checkmate?
  end

  def check?
  end

  def whos_turn
    @player_one.data[:next_turn] ? @player_one : @player_two
  end

  def continue
    print "press any key to continue.."
    STDIN.getch
    print "            \r"
  end
end

