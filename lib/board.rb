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
  attr_accessor :board, :start_coordinates, :finish_coordinates, :start_square, :finish_square, :player1, :player2
  attr_reader :save_value

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @save_value = false
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

  def board_pretty_print(player)
    system 'clear'
    print_player_message(player)
    last_color_brown = false
    string = ''
    number = 8
    puts "\e[36m        a  b  c  d  e  f  g  h \e[0m"
    board.each_with_index do |array, index|
      last_color_brown = last_color_brown == false ? true : false
      array.each do |item|
        if item == ''
          if last_color_brown
            string << ("\x1b[47m #{item}  \e");
            string << ("\x1b[0m");
            last_color_brown = false
          else
            string << ("\x1b[100m #{item}  \e");
            string << ("\x1b[0m");
            last_color_brown = true
          end
        else
          if last_color_brown
            string << ("\x1b[47m #{item.unicode} \e");
            string << ("\x1b[0m");
            last_color_brown = false
          else
            string << ("\x1b[100m #{item.unicode} \e");
            string << ("\x1b[0m");
            last_color_brown = true
          end
        end
      end
        print "     #{number} #{string} #{number}\n"
        string = ''
        number -= 1
    end
    puts "\e[36m        a  b  c  d  e  f  g  h \e[0m"
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
    user_input
  end

  def user_input
    input = gets.chomp
    unless check_input(input) == true
      invalid_input
      user_input
    end
    input.upcase == 'SAVE' ? @save_value = true : convert_to_numbers(input)
  end

  def check_input(string)
    return true if string.downcase == 'castle'

    string.length == 4 ? true : false
  end

  def invalid_input
    puts "Invalid input. Try again:"
  end

  def convert_to_numbers(string)
    return false if string.downcase == 'castle' 
    numbers = { a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8 }
    string_split = string.split(//)
    @start_coordinates = [numbers[string_split[0].to_sym], string_split[1].to_i]
    @finish_coordinates = [numbers[string_split[2].to_sym], string_split[3].to_i]
    set_start_finish_squares(@start_coordinates, @finish_coordinates)
  end


  def set_start_finish_squares(start, finish)
    @start_square = @board[8- @start_coordinates[1]][@start_coordinates[0] - 1]
    @finish_square = @board[8- @finish_coordinates[1]][@finish_coordinates[0]- 1]
  end

  def reset_variables
    @start_square = nil
    @finish_square = nil
    @start_coordinates = []
    @finish_coordinates = []
  end

  def check_for_end_pawn(player, opponent)
    reintroduce_piece(find_end_pawn(player), player)
  end

  def find_end_pawn(player)
    end_row = player.data[:number] == 1 ? @board[7] : @board[0]
    num = player.data[:number] == 1 ? 1 : 8
    coordinates = []
    end_row.each do |piece|
      next if piece == "" || piece.which_player != player

      if piece.type == "Pawn" && piece.which_player == player 
        coordinates << [end_row.index(piece) + 1, num]
      end
    end
    coordinates.empty? ? nil : coordinates[0]
  end

  def reintroduce_piece(pawn, player)
    return nil if pawn == nil
    input = get_input
    piece_to_swap = input.split('')
    piece_to_swap[0] = piece_to_swap[0].upcase
    piece_to_swap = create_new_piece(piece_to_swap, player)
    initiate_swap(pawn, piece_to_swap)
  end

  ## method accepts first input if it is wrong. 


  def get_input
    input = ''
    num = 1
    loop do
      break if %w[rook bishop queen knight].include?(input.downcase)

      invalid_input if num > 1
      puts 'Choose a piece to swap your Pawn with'
      input = gets.chomp
      num += 1
    end
    input
  end

  def create_new_piece(piece, player)
    Object.const_get(piece.join('')).new(player)
  end

  def print_piece_options(player)
    player.graveyard.each do |piece| 
      num = 1
      puts "#{num}." + " #{piece.type}"
      num += 1
    end
  end

  def initiate_swap(pawn, piece_to_swap)
    player = piece_to_swap.which_player
    @board[8 - pawn[1]][pawn[0] - 1] = piece_to_swap
    player.graveyard.delete(piece_to_swap)
  end

  def print_player_message(player)
    puts player.data[:number] == 1 ? "\n    #{player.data[:name]}'s go! Move the " + "\e[92mGREEN\x1b[0m" + " peices." : "\n #{player.data[:name]}'s go! Move the " + "BLACK".light_black + " peices. \n"
    puts "\n"
  end
  
end
