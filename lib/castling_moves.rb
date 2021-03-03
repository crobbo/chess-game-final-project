class Castling

  def initialize
    @king = nil
    @king_first = nil
    @rook1 = nil
    @rook1_first = nil
    @rook2 = nil
    @rook2_first = nil
  end

  def castle_pieces(board, player, check)
    find_king(board, player)
    find_rooks(board, player)
    rook = return_rook(board, player)
    return false if rook == false
    if !check && empty_squares? && empty_squares_not_attacked? 
      move_king
      move_rook
    else
      reset_variables
      true
    end
  end

  def move_king
  end

  def move_rook
  end

  

  def empty_squares_not_attacked?
  end

  def return_rook(board, player)
    if @rook1.first_move && !@rook2.first_move
      @rook1
    elsif !rook1.first_move && @rook2.first_move
      @rook2
    elsif !@rook1.first_move && !@rook2.first_move
      false
    else
      which_rook(board, player)
    end
  end

  def which_rook(board, player)
    rook_one_space = empty_squares?(board, player, @rook1, @king)
    rook_two_space = empty_squares?(board, player, @rook2, @king)
    if rook_one_space && rook_two_space
      # player chooses rook?
    elsif rook_one_space && !rook_two_space
      @rook1
    elsif !rook_one_space && rook_two_space
      @rook2
    else
      false
    end
  end

  def empty_squares?(board, player, rook, king)
    row = player.data[:num] == 1 ? 0 : 7
    ## need to add something here. it works for rook being in column 1 but not column 8
    squares_between = board[row].slice(board.index(rook) + 1, board.index(king))
    num_squares = 0
    squares_between.each do |square|
      num_squares += 1
      break if square != ''
    end
    num_squares == squares_between.length
  end

  def find_king(board, player)
    board.each do |row|
      row.each do |square|
        next if square == ''

        if square.type == 'King' && square.which_player == player
          @king = square
          @king_first = square.first_move
        end
      end
    end
  end

  def find_rook1(board, player)
    board.each do |row|
      row.each do |sqaure|
        next if square == ''

        if square.type == 'Rook' && square.which_player == player
          if rook1 == nil
            @rook1 = square
            @rook1_first = square.first_move
          else
            @rook2 = square
            @rook2_first = square.first_move
          end
        end
      end
    end
  end

  def find_rook2
  end

  def reset_variables
  end
end