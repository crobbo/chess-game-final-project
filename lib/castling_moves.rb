class Castling

  def initialize
    @king = nil
    @rook = nil

    @rook1 = nil
    @rook2 = nil
  end

  def find_king(board, player)
    board.each do |row|
      row.each do |square|
        next if square == ''

        if square.type == 'King' && square.which_player == player
          @king = square
        end
      end
    end
  end

  def find_rook(board, player)
    board.each do |row|
      row.each do |square|
        next if square == ''

        if square.type == 'Rook' && square.which_player == player
          if @rook1.nil?
            @rook1 = square
          else
            @rook2 = square
          end
        end
      end
    end
  end

  def castle_pieces(chess, player, check)
    find_king(chess.board, player)
    find_rook(chess.board, player)
    binding.pry
    return false if check == true
    # binding.pry
    return false unless king_first_move?(@king)
    # binding.pry
    return false unless rook_first_move?(return_rook(chess.board, player))
    # binding.pry
    return false unless empty_squares?(chess.board, player, @king, @rook)
    binding.pry
    return false if empty_squares_attacked?(chess, chess.board, player)
    move_pieces(@king, @rook, )
  end

  def move_pieces(king, rook, board)
    start_row = player.data[:number] == 1 ? 0 : 7
    king_index = board[start_row].index(@king)
    rook_index = board[start_row].index(@rook) 
    if rook_index.zero?
      board[start_row][king_index - 2] = @king
      board[start_row][king_index] = ''
      board[start_row][king_index - 1] = @rook
      board[start_row][0] = ''
    else
      board[start_row][king_index + 2] = @king
      board[start_row][king_index] = ''
      board[start_row][king_index + 1] = @rook
      board[start_row][7] = ''
    end
  end
  
  def king_first_move?(king)
    king.first_move ? true : false
  end

  def rook_first_move?(rook)
    return false if rook == false

    rook.first_move ? true : false
  end

  def return_rook(board, player)
    if rook_first_move?(@rook1) && !rook_first_move?(@rook2)
      @rook = @rook1
    elsif !rook_first_move?(@rook1) && rook_first_move?(@rook2)
      @rook = @rook2
    elsif !rook_first_move?(@rook1) && !rook_first_move?(@rook2)
      false
    else
      player_selects_rook(board)
    end
  end


  def player_selects_rook(board)
    puts "Enter coordinates of the rook you'd like to castle"
    string = gets.chomp
    numbers = { a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8 }
    string_split = string.split(//)
    coordinates = [numbers[string_split[0].to_sym], string_split[1].to_i]
    @rook = board[8- coordinates[0]][coordinates[1] - 1]
  end
  
  def empty_squares?(board, player, king, rook)
    row = player.data[:number] == 1 ? 0 : 7
    squares_between = board[row].index(rook).zero? ? board[row].slice(board[row].index(rook) + 1, board[row].index(king)) : board[row].slice(board[row].index(king) + 1, board[row].index(rook))
    num_squares = 0
    squares_between.each do |square|
      num_squares += 1
      break if square != ''
    end
    num_squares == squares_between.length
  end

  def empty_squares_attacked?(chess, board, player)
    start_row = player.data[:number] == 1 ? 0 : 7
    squares = which_squares(board, start_row, @rook)
    attacked = []
    board.each do |row| 
      row.each do |square|
        next if square == ''
        next if square.which_player == player
        squares.each do |coordinate|
          set_start_finish_values(chess, board, square, coordinate, start_row)
          attacked << square.valid_move?(chess, square.which_player) ? true : false
        end
      end
    end
    attacked.include?(true)
  end

  def set_start_finish_values(chess, board, piece, finish_coordinates, row)
    chess.start_coordinates = find_coordinates(board, piece)
    chess.start_square = piece
    chess.finish_coordinates = finish_coordinates
    chess.finish_square = board[row][finish_coordinates[0] - 1]
  end

  def which_squares(board, row, rook)
    if row.zero?
      board[row].index(rook).zero? ? [[3, 8], [4, 8]] : [[6, 8], [7, 8]]
    else
      board[row].index(rook).zero? ? [[3, 8], [4, 8]] : [[6, 8], [7, 8]]
    end
  end

  def find_coordinates(board, square)
    x = nil
    y = nil
    board.each_with_index do |row, y_index|
      row.each_with_index do |column, x_index|
        if row.include?(square)
          y = 8 - y_index
        end
        if column == square
          x = x_index + 1
        end
      end
    end
    [x, y]
  end

  def reset_variables(chess)
  end
end