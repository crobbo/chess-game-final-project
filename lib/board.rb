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

  def board_pretty_print
    last_color_brown = false
    string = ''
    number = 1
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
        number += 1
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
    puts "Enter start square & finish square (Example: a1a1):"
    input = gets.chomp
    if check_input(input) == false
      invalid_input
      return nil
    end
    input.upcase == 'SAVE' ? @save_value = true : convert_to_numbers(input)
  end

  def check_input(string)
    string.length != 4 ? false : true
  end

  def invalid_input
    puts "Invalid input. Try again:"
    user_input
  end

  def convert_to_numbers(string)
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

  # def choose_coordinates
  #   puts 'Select piece to move:'.light_blue
  #   @start_square = obtain_start_square
  #   return nil if @start_square == 'SAVE'

  #   puts 'Select square to move to:'.light_blue
  #   @finish_square = obtain_finish_square
  #   return nil if @finish_square == 'SAVE'

  # end

  # def obtain_start_square
  #   puts 'Enter X coordinate:'
  #   x = user_input
  #   return 'SAVE' if x == 'SAVE'

  #   puts 'Enter Y coordinate:'
  #   y = user_input
  #   return 'SAVE' if y == 'SAVE'

  #   @start_coordinates << x
  #   @start_coordinates << y
  #   @board[8-y][x-1]
  # end

  # def obtain_finish_square
  #   puts 'Enter X coordinate:'
  #   x = user_input
  #   return 'SAVE' if x == 'SAVE'

  #   puts 'Enter Y coordinate:'
  #   y = user_input
  #   return 'SAVE' if y == 'SAVE'

  #   @finish_coordinates << (x)
  #   @finish_coordinates << (y)
  #   @board[8-y][x-1]
  # end

  # def user_input
  #   num = gets.chomp
  #   if num.upcase == 'SAVE'
  #     num.upcase
  #   elsif num.to_i.positive? && num.to_i < 9
  #     num.to_i
  #   else
  #     puts 'Incorrect input, try again'
  #     user_input
  #   end
  # end


  

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
    coordinates.empty? ? nil : coordinates
  end

  def reintroduce_piece(pawn, player)
    return nil if pawn == nil

    print_piece_options(player)
    puts "#{player.data[:name]} choose a piece to swap your Pawn with."
    piece_to_swap = player.graveyard[user_input - 1]
    initiate_swap(pawn, piece_to_swap)
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
    move_pawn = @board[8 - pawn[1]][pawn[0] - 1]
    player.graveyard << move_pawn
    @board[8 - pawn[1]][pawn[0] - 1] = piece_to_swap
    player.graveyard.delete(piece_to_swap)
  end
  
end
