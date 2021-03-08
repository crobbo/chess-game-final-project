class Castling

  def initialize
    @king = nil
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

  def castle_pieces(board, player, check)
    find_king(board, player)
    find_rook(board, player)
    return false if check == true
    return false unless king_first_move?(@king)
    return false unless rook_first_move?(return_rook(board, player))
    return false unless empty_sqaures?(board, player, king, rook)
    # return false unles
  end

  def king_first_move?(king)
    king.first_move? ? true : false
  end

  def rook_first_move?(rook)
    return false if rook == false

    rook.first_move? ? true : false
  end

  def return_rook(board, player)
    if rook_first_move?(@rook1) && !rook_first_move?(@rook2)
      @rook1
    elsif !rook_first_move?(@rook1) && rook_first_move?(@rook2)
      @rook2
    elsif !rook_first_move?(@rook1) && !rook_first_move?(@rook2)
      false
    end
  end
  
  def empty_squares?(board, player, rook, king)
    row = player.data[:num] == 1 ? 0 : 7
    squares_between = board.index(rook).zero? ? board[row].slice(board.index(rook) + 1, board.index(king)) : board[row].slice(board.index(king) + 1, board.index(rook))
    num_squares = 0
    squares_between.each do |square|
      num_squares += 1
      break if square != ''
    end
    num_squares == squares_between.length
  end

  def reset_variables
  end
end