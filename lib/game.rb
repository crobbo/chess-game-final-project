# frozen_string_literal: true
require_relative 'board'
require_relative 'errors'
require_relative 'save_load'

# Controls the gameplay
class Game

  def initialize(player1, player2, board_class = Board.new(player1, player2))
    @chess = board_class
    @player_one = player1
    @player_two = player2
    @error = Errors.new
    @player_one_in_check = false
    @player_two_in_check = false
    @save_game_variables = []
    @save_game = Save_load.new
  end

  def store_save_variables
    @save_game_variables = [@chess.board, @player_one, @player_two, @player_one_in_check, @player_two_in_check]  
  end

  def set_variables_after_load(array)
    return nil if array == nil
    @chess.board = array[0][0]
    @player_one = array[1]
    @chess.player1 = array[1]
    @player_two = array[2]
    @chess.player2 = array[2]
    @player_once_in_check = array[3]
    @player_two_in_check = array[4]
  end

  def loaded
    puts 'Game loaded'
    @chess.reset_variables
  end

  def play
    set_variables_after_load(@save_game.ask_for_load) == nil ? introduction : loaded
    loop do
      "\n"
      puts whos_turn.data[:number] == 1 ? "\n#{whos_turn.data[:name]}'s go! Move the " + "\e[92mgreen\e[0m" + " peices." : "\n #{whos_turn.data[:name]}'s go! Move the " + "\e[30mblack\e[0m" + " peices. \n"
      @chess.board_pretty_print
      valid_move
      check_for_winner
      check?(opponents_king_coordinates) ? print_check_message : nil # improve upon this by limtiing the next players move to only moves are a king and out of check.
      @chess.check_for_end_pawn(whos_turn, return_opponent)
      @chess.reset_variables
      set_turn
    end
  end

  def check_for_winner
    if @player_one_in_check
      check?(opponents_king_coordinates) ? game_over(@player_two, @player_one) : @player_one_in_check = false
    elsif @player_two_in_check
      check?(opponents_king_coordinates) ? game_over(@player_one, @player_two) : @player_two_in_check = false
    end
  end

  def game_over(winner, loser)
    puts "#{winner.data[:name]} wins! Better luck next time #{loser.data[:name]}"
    exit
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
      @error.invalid_move
      @chess.reset_variables
      valid_move
    end
  end

  def move_piece
    @chess.choose_coordinates
    store_save_variables
    @chess.save_value ? @save_game.save(@save_game_variables) : nil
    return false if @chess.board[8 - @chess.start_coordinates[1]][@chess.start_coordinates[0] - 1] == ''
    return false unless @chess.start_square.which_player == whos_turn  # checks player is moving piece which belongs to them
    return false unless @chess.start_square.valid_move?(@chess, whos_turn)

    pawn_fist_move?
    adjust_board
  end

  def adjust_board
    finish_piece = @chess.board[8 - @chess.finish_coordinates[1]][@chess.finish_coordinates[0] - 1]
    finish_piece == '' ? nil : return_opponent.add_to_graveyard(finish_piece)
    @chess.board[8 - @chess.finish_coordinates[1]][@chess.finish_coordinates[0] - 1] = @chess.start_square
    @chess.board[8 - @chess.start_coordinates[1]][@chess.start_coordinates[0] - 1] = ''
  end

  def pawn_fist_move?
    if @chess.start_square.type == 'Pawn' && @chess.start_square.first_move == true
      @chess.start_square.change_first_move
    else
      nil
    end
  end

  def who_plays_first
    # sleep 1.5
    puts "Computer will randomly select the first player..."
    # sleep 1.5
    puts "Building random selection machine"
    # sleep 1.5
    puts 'Adding magic sauce'
    # sleep 1.5
    puts 'Initiating start up'
    # sleep 2
    arr = [@player_one.data[:name], @player_two.data[:name]]
    name = arr.sample
    if @player_one.data[:name] == name
      @player_one.data[:next_turn] = true
      @player_two.data[:next_turn] = true
    else
      @player_two.data[:next_turn] = true
      @player_one.data[:next_turn] = false
    end
    name.upcase
  end

  def check?(king_coordinates)
    check = false
    @chess.board.each do |array|
      array.each do |square|
        next if square == '' || square.which_player != whos_turn
        if square.which_player == whos_turn
          row = @chess.board.detect { |aa| aa.include?(square) }
          @chess.start_coordinates = [row.index(square) + 1, 8 - @chess.board.index(row)]
          @chess.start_square = square
          square.valid_move?(@chess, square.which_player) ? check = true : next
        end
      end
    end
    check ? (whos_turn == @player_one ? @player_one_in_check = true : @player_two_in_check = true) : nil
    check
  end

  def opponents_king_coordinates
    @chess.board.each do |array|
      array.each do |square|
        next if square == '' || square.which_player == whos_turn

        if square.type == 'King' && square.which_player != whos_turn
          row = @chess.board.detect{ |aa| aa.include?(square) }
          @chess.finish_coordinates = [row.index(square) + 1, 8 - @chess.board.index(row)]
          @chess.finish_square = square
        end
      end
    end
  end


  def current_players_king_coordinates
    @chess.board.each do |array|
      array.each do |square|
        next if square == '' || square.which_player != whos_turn

        if square.type == 'King' && square.which_player == whos_turn
          row = @chess.board.detect{ |aa| aa.include?(square) }
          @chess.finish_coordinates = [row.index(square) + 1, 8 - @chess.board.index(row)]
          @chess.finish_square = square
        end
      end
    end
    @chess.finish_coordinates
  end

  def print_check_message
    name = whos_turn == @player_one ? @player_two.data[:name] : @player_two.data[:name]
    puts "#{name}'s King is in Check :/"
  end

  def set_turn
    if @player_one.data[:next_turn]
      @player_two.data[:next_turn] = true
      @player_one.data[:next_turn] = false
    else
      @player_two.data[:next_turn] = false
      @player_one.data[:next_turn] = true
    end
  end

  def whos_turn
    @player_one.data[:next_turn] ? @player_one : @player_two
  end

  def return_opponent
    @player_one.data[:next_turn] ? @player_two : @player_one 
  end

  def continue
    print "press any key to continue.."
    STDIN.getch
    print "            \r"
  end
end
