# frozen_string_literal: true
require_relative 'board'
require_relative 'errors'

# Controls the gameplay
class Game
  
  def initialize(player1, player2, board_class = Board.new(player1, player2))
    @chess = board_class
    @player_one = player1
    @player_two = player2
    @error = Errors.new
  end

  def play
    introduction
    loop do
      puts "#{whos_turn.data[:name]}'s go!"
      @chess.board_pretty_print
      # binding.pry
      valid_move
      check?(opponents_king_coordinates) ? print_check_message : nil # improve upon this by limtiing the next players move to only moves are a king and out of check.
      break if checkmate?

      @chess.reset_variables
      set_turn
    end
    game_over # write this
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
    return false if @chess.board[8 - @chess.start_coordinates[1]][@chess.start_coordinates[0] - 1] == ''
    return false unless @chess.start_square.which_player == whos_turn  # checks player is moving piece which belongs to them
    return false unless @chess.start_square.valid_move?(@chess, whos_turn)

    whos_turn.add_to_graveyard(@chess, @chess.board)
    pawn_fist_move?
    adjust_board
  end

  def adjust_board
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
      @player_two.data[:next_turn] = true
    else
      @player_two.data[:next_turn] = true
      @player_one.data[:next_turn] = false
    end
    name.upcase
  end

  def checkmate?  ### Error when king appears to be in checkmate? but the king could take the opponenents peice to move out of it. 
    in_check = 0
    # king = @chess.board[8 - @chess.finish_coordinates[1]][@chess.finish_coordinates[0] - 1]
    king = nil
    @chess.board.each do |row|
      row.each do |square|
        next if square == '' || square.which_player == whos_turn
        square.type == 'King' ? king = square : next
      end
    end
    binding.pry
    possible_moves = king.possible_moves(@chess.finish_coordinates)
    moves = possible_moves.each.filter { |x| ((x[0].positive? && x[0] < 9) && (x[1].positive? && x[1] < 9)) }
    moves = moves.filter do |move|
      @chess.start_coordinates = move
      king.valid_move?(@chess, whos_turn)
    end
    moves.each { |a| check?(a) ? (in_check += 1) : nil } 
    in_check == moves.length ? true : false
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

  def continue
    print "press any key to continue.."
    STDIN.getch
    print "            \r"
  end
end
