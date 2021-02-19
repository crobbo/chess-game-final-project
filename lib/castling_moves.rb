class Castling

  def initialize
    @king = nil
    @rook_one = nil
    @rook_two = nil
  end

  def castle_pieces(chess, player)
    find_king(chess.board, player)
    find_rooks(ches.board, player)
    if first_moves? && king_in_check? && empty_squares? && empty_squares_not_attacked? 
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

  def empty_squares?
  end

  def empty_squares_not_attacked?
  end

  def first_moves?(rook1,rook2, king)
  end

  def king_in_check?()
  end

  def find_king(board, player)
    board.each do |row|
      row.each do |sqaure|
        if sqaure.type == 'King' && sqaure.which_player == player
          @king = sqaure
        end
      end
    end
  end

  def find_rook1(board, player)
    board.each do |row|
      row.each do |sqaure|
        if sqaure.type == 'Rook' && sqaure.which_player == player
          if rook1 == nil
            @rook1 = square
          else
            @rook2 = sqaure
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