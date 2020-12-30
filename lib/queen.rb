# stores methods for Queen class

require_relative 'piece'

class Queen < Piece

  def moves
    # Queen can move anywhere on the board.
  end

  def valid_move?(chess, player)
    squares = possible_moves(chess) 

    if squares[0][0].include?(chess.finish_coordinates) && space_between_diagonals?(chess, squares[0])
      if chess.finish_square == ''
        return true
      elsif chess.finish_square.which_player != player
        return true
      elsif chess.finish_square.which_player == player
        return false
      else
        return false
      end
    elsif squares[0][1].include?(chess.finish_coordinates) && space_between_diagonals?(chess, squares[0])
      if chess.finish_square == ''
        return true
      elsif chess.finish_square.which_player != player
        return true
      elsif chess.finish_square.which_player == player
        return false
      else
        return false
      end
    elsif squares[1][0].include?(chess.finish_coordinates) && space_between_antediagonals?(chess, squares[1])
      if chess.finish_square == ''
        return true
      elsif chess.finish_square.which_player != player
        return true
      elsif chess.finish_square.which_player == player
        return false
      else
        return false
      end
    elsif squares[1][1].include?(chess.finish_coordinates) && space_between_antediagonals?(chess, squares[1])
      if chess.finish_square == ''
        return true
      elsif chess.finish_square.which_player != player
        return true
      elsif chess.finish_square.which_player == player
        return false
      else
        return false
      end
    elsif squares[2].include?(chess.finish_coordinates) && space_between_row?(chess)
      if chess.finish_square == ''
        return true
      elsif chess.finish_square.which_player != player
        return true
      elsif chess.finish_square.which_player == player
        return false
      else
        return false
      end
    elsif squares[3].include?(chess.finish_coordinates) && space_between_column?(chess)
      if chess.finish_square == ''
        return true
      elsif chess.finish_square.which_player != player
        return true
      elsif chess.finish_square.which_player == player
        return false
      else
        return false
      end
    else 
      false
    end
  end

  def possible_moves(chess)
    arr = []
    arr << find_diagonals(chess)
    arr << find_antediagonals(chess)
    arr << find_row_squares(chess.start_coordinates)
    arr << find_column_squares(chess.start_coordinates)
    arr
  end

  def find_column_squares(start_coordinates)
    arr = []
    j = 1
    until j > 8
      arr << [start_coordinates[0], j]
      j += 1
    end
    arr.delete(start_coordinates)
    arr
  end

  def find_row_squares(start_coordinates)
    arr = []
    i = 1
    until i > 8
      arr << [i, start_coordinates[1]]
      i += 1
    end
    arr.delete(start_coordinates)
    arr
  end

  def space_between_column?(chess)
    return false unless chess.start_coordinates[0] == chess.finish_coordinates[0]

    row = transpose_column(chess)
    row.index(chess.start_square) < row.index(chess.finish_square) ? row : row = row.reverse
    start = row.index(chess.start_square) + 1
    finish = row.index(chess.finish_square) - 1
    result = row[start..finish].each do |x|
      return false if x != ''
      break if x != ''
    end
    result == false ? false : true
  end

  def transpose_column(chess)
    transposed_board = chess.board.transpose 
    transposed_board[chess.start_coordinates[0]- 1]
  end

  def space_between_row?(chess)
    return false unless chess.start_coordinates[1] == chess.finish_coordinates[1]

    find_row = chess.board[8 - chess.start_coordinates[1]]
    start = chess.start_coordinates[0]
    finish = chess.finish_coordinates[0] - 2
    find_path = find_row[start..finish]
    result = find_path.each do |x|
      return false if x != ''
      break if x != ''
    end
    result == false ? false : true
  end

  def same_axis?(start_coordinates, finish_coordinates)
    if start_coordinates[0] == finish_coordinates[0]
      true
    elsif start_coordinates[1] == finish_coordinates[1]
      true
    else
      false
    end
  end

  def find_diagonals(chess)
    arr = []
    left_coordinates = chess.start_coordinates.map(&:clone)
    right_coordinates = chess.start_coordinates.map(&:clone)
    arr << diag_bottom_left(left_coordinates)
    arr << diag_top_right(right_coordinates)
    arr
  end

  def diag_bottom_left(coordinates)
    arr = []
    loop do
      coordinates[0] = coordinates[0] - 1
      coordinates[1] = coordinates[1] - 1
      break if coordinates.include?(0) || coordinates.include?(9)

      arr << [coordinates[0], coordinates[1]]
    end
    arr
  end

  def diag_top_right(coordinates)
    arr = []
    loop do
      coordinates[0] = coordinates[0] + 1
      coordinates[1] = coordinates[1] + 1
      break if coordinates.include?(0) || coordinates.include?(9)

      arr << [coordinates[0], coordinates[1]]
    end
    arr
  end

  def find_antediagonals(chess)
    arr = []
    left_coordinates = chess.start_coordinates.map(&:clone)
    right_coordinates = chess.start_coordinates.map(&:clone)
    arr << diag_top_left(left_coordinates)
    arr << diag_bottom_right(right_coordinates)
    arr
  end

  def diag_top_left(coordinates)
    arr = []
    loop do
      coordinates[0] = coordinates[0] - 1
      coordinates[1] = coordinates[1] + 1
      break if coordinates.include?(0) || coordinates.include?(9)

      arr << [coordinates[0], coordinates[1]]
    end
    arr
  end

  def diag_bottom_right(coordinates)
    arr = []
    loop do
      coordinates[0] = coordinates[0] + 1
      coordinates[1] = coordinates[1] - 1
      break if coordinates.include?(0) || coordinates.include?(9)

      arr << [coordinates[0], coordinates[1]]
    end
    arr
  end

  def space_between_antediagonals?(chess, ante_diags)
    start = chess.start_coordinates
    finish = chess.finish_coordinates
    moves = start[0] < finish[0] ? ante_diags[1] : ante_diags[0]
    bishop_route = moves[0..moves.index(finish)]
    bishop_route.pop
    result = bishop_route.each do |i|
      square = chess.board[8 - i[1]][i[0]- 1]
      return false if square != ''
      break if square != ''
    end
    result == false ? false : true
  end

  def space_between_diagonals?(chess, diags)
    start = chess.start_coordinates
    finish = chess.finish_coordinates
    moves = start[0] < finish[0] ? diags[1] : diags[0]
    bishop_route = moves[0..moves.index(finish)]
    bishop_route.pop
    result = bishop_route.each do |i|
      square = chess.board[8 - i[1]][i[0] - 1]
      return false if square != ''
      break if square != ''
    end
    result == false ? false : true
  end


  def unicode
    "\u265B"
  end

end
