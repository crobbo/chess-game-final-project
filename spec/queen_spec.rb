require 'rspec/autorun'

require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/pawn'

describe Queen do

  let(:player_one) { instance_double(Player)}
  let(:player_two) { instance_double(Player)}

  describe 'valid_move?' do
    context 'queen is making a diagonal move' do

      xit 'returns true if finish square contains opponents piece' do
      end

      xit 'returns false if finish square contains players own piece' do
      end

      xit 'returns true if finish square is empty' do
      end
    end

    context 'queen is making  move horizontal or vertical move' do

      xit 'returns true if finish square contains opponents piece' do
      end

      xit 'returns false if finish square contains players own piece' do
      end

      xit 'returns true if finish square is empty' do
      end
    end
  end

  describe 'possible_moves' do
    context 'for a given start coodinate' do
    subject(:queen_possible_moves) { described_class.new(player_one)}
    let(:chess) { instance_double(Board, start_coordinates: [3, 4]) }

      it 'returns an array of horizontal moves' do
        expect(queen_possible_moves.possible_moves(chess)[2]).to eq([[1, 4], [2, 4], [4, 4], [5, 4], [6, 4], [7, 4], [8, 4]])
      end

      it 'returns an array of vertical moves' do
        expect(queen_possible_moves.possible_moves(chess)[3]).to eq([[3, 1], [3, 2], [3, 3], [3, 5], [3, 6], [3, 7], [3, 8]])
      end

      it 'returns an array of diagonal moves' do
        expect(queen_possible_moves.possible_moves(chess)[0]).to contain_exactly([[2, 3], [1, 2]], [[4, 5], [5, 6], [6, 7], [7, 8]])
      end

      it 'returns an array of antediagonal moves' do
        expect(queen_possible_moves.possible_moves(chess)[1]).to contain_exactly([[2, 5], [1, 6]], [[4, 3], [5, 2], [6, 1]])
      end
    end
  end

  describe 'find_diagonals' do
    subject(:queen_diags) { described_class.new(player_one) }

    let(:chess) { instance_double(Board, start_coordinates:[3, 6]) }

    context 'when find_diagonals is called' do

      it 'returns a nested array' do
        expect(queen_diags.find_diagonals(chess)).to eq([[[2, 5], [1, 4]], [[4, 7], [5, 8]]])
      end
    end
  end

  describe 'diag_bottom_left' do
    subject(:queen_bottom_left) { described_class.new(player_one) }

    context 'when start coordinates are inputted' do

      it 'returns array of coordinates' do
        expect(queen_bottom_left.diag_bottom_left([5, 6])).to eq([[4, 5], [3, 4], [2, 3], [1, 2]])
      end

      it 'returns array of coordinates' do
        expect(queen_bottom_left.diag_bottom_left([1, 1])).to eq([])
      end
    end

  end

  describe 'diag_top_right' do
    subject(:queen_top_right) { described_class.new(player_one) }

    context 'when start coordinates are inputted' do
      it 'returns an array of coordinates' do
        expect(queen_top_right.diag_top_right([1, 1])).to eq([[2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [8, 8]])
      end

      it 'returns an array of coordinates' do
        expect(queen_top_right.diag_top_right([2, 4])).to eq([[3, 5], [4, 6], [5, 7], [6, 8]])
      end
    end

  end

  describe 'find_antediagonals' do
    subject(:queen_antediags) { described_class.new(player_one) }

    let(:chess) { instance_double(Board, start_coordinates: [5, 4]) }

    context 'when find_diagonals is called' do

      it 'returns a nested array' do
        expect(queen_antediags.find_antediagonals(chess)).to eq([[[4, 5], [3, 6], [2, 7], [1, 8]],[[6, 3], [7, 2], [8, 1]]])
      end
    end
  end

  describe 'diag_bottom_right' do
    subject(:queen_bottom_right) { described_class.new(player_one) }

    context 'when start coordinates are inputted' do
      it 'returns an array of coordinates' do
        expect(queen_bottom_right.diag_bottom_right([1, 1])).to eq([])
      end

      it 'returns an array of coordinates' do
        expect(queen_bottom_right.diag_bottom_right([2, 4])).to eq([[3, 3], [4, 2], [5, 1]])
      end
    end
  end

  describe 'diag_top_left' do
    subject(:queen_top_left) { described_class.new(player_one) }

    context 'when start coordinates are inputted' do
      it 'returns an array of coordinates' do
        expect(queen_top_left.diag_top_left([7, 1])).to eq([[6, 2], [5, 3], [4, 4], [3, 5], [2, 6], [1, 7]])
      end

      it 'returns an array of coordinates' do
        expect(queen_top_left.diag_top_left([2, 4])).to eq([[1, 5]])
      end
    end
  end

  describe 'find_column_squares' do
    subject (:queen_column) { described_class.new(player_one)}

    context 'when edge square is the starting square' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [1, 2]) }
  

      it 'returns all squares on the y-axis' do
        expect(queen_column.find_column_squares(chess.start_coordinates)).to contain_exactly([1, 1], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8])
      end

    end

    context 'when centre square is the starting square' do
      
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [5, 4])}

      it 'returns all squares on the y-axis' do
        expect(queen_column.find_column_squares(chess.start_coordinates)).to contain_exactly([5, 1], [5, 2], [5, 3], [5, 5], [5, 6], [5, 7], [5, 8])
      end

    end
  end

  describe 'find_row_squares' do
    subject (:queen_row) { described_class.new(player_one)}

    context 'when edge square is the starting square' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [1, 2]) }


      it 'returns all squares on the x-axis' do
        expect(queen_row.find_row_squares(chess.start_coordinates)).to contain_exactly([2, 2], [3, 2], [4, 2], [5, 2], [6, 2], [7, 2], [8, 2])
      end

    end

    context 'when centre square is the starting square' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [5, 4])}

      it 'returns all squares on the x-axis' do
        expect(queen_row.find_row_squares(chess.start_coordinates)).to contain_exactly([1, 4], [2, 4], [3, 4], [4, 4], [6, 4], [7, 4], [8, 4])
      end

    end
  end
  
  describe '#same_axis??' do

    subject(:queen_axis) { described_class.new(player_one) }

    context 'when queen is selected to move to a target sqaure' do
      it 'returns true if start_sqaure and finish_square are on the same x-axis' do
        start_coordinates = [2, 3]
        finish_coordinates = [2, 8]
        expect(queen_axis.same_axis?(start_coordinates, finish_coordinates)).to eq(true)
      end

      it 'returns true if start_sqaure and finish_square are on the same y-axis' do
        start_coordinates = [4, 8]
        finish_coordinates = [2, 8]
        expect(queen_axis.same_axis?(start_coordinates, finish_coordinates)).to eq(true)
      end

      it 'returns false if start_sqaure and finish_square are on NOT the same x-axis' do
        start_coordinates = [2, 3]
        finish_coordinates = [1, 6]
        expect(queen_axis.same_axis?(start_coordinates, finish_coordinates)).to eq(false)
      end
    end
  end

  describe 'space_between_diagonals' do
    subject(:queen_diagonals) { described_class.new(player_one) }

    context 'when there is clear space between start and finish' do

    let(:chess) { instance_double(Board, board: [
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '']
    ], start_coordinates: [1, 1], finish_coordinates: [8, 8]) }

      it 'returns true' do
        expect(queen_diagonals.space_between_diagonals?(chess, [[[]],[[2, 2],[3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [8, 8]]])).to eq(true)
      end
    end

    context "when a piece is between start and finish" do
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [1, 1], finish_coordinates: [8, 8]) }

      let(:players_piece) { instance_double(Pawn) }

      before do
        chess.board[4][3] = players_piece
      end

      it 'returns false' do
        expect(queen_diagonals.space_between_diagonals?(chess, [[[]],[[2, 2],[3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [8, 8]]])).to eq(false)
      end
    end

    context 'when x-coordinate of start is greater than finish' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [8, 8], finish_coordinates: [1, 1]) }

      let(:players_piece) { instance_double(Pawn) }

      it 'returns true when space between' do
        expect(queen_diagonals.space_between_diagonals?(chess, [[[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1]], [[]]] )).to eq(true)
      end

      it 'returns false when piece in the way' do
        chess.board[4][3] = players_piece
        expect(queen_diagonals.space_between_diagonals?(chess, [[[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1]], [[]]])).to eq(false)
      end
    end
  

    context 'when x-coordinate of start is greater than finish' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [6, 6], finish_coordinates: [2, 2]) }

      let(:players_piece) { instance_double(Pawn) }

      it 'returns true when space between' do
        expect(queen_diagonals.space_between_diagonals?(chess, [[[5, 5], [4, 4], [3, 3], [2, 2], [1, 1]], [[7, 7], [8, 8]]])).to eq(true)
      end

      it 'returns false when piece in the way' do
        chess.board[4][3] = players_piece
        expect(queen_diagonals.space_between_diagonals?(chess, [[[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1]], [[]]])).to eq(false)
      end
    end
  end

  describe '#space_between_antediagonals?' do

    subject(:queen_antediagonals) { described_class.new(player_one) }

    context 'when there is clear space between start and finish' do

    let(:chess) { instance_double(Board, board: [
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '']
    ], start_coordinates: [2, 6], finish_coordinates: [6, 2]) }

      it 'returns true' do
        expect(queen_antediagonals.space_between_antediagonals?(chess, [[[1, 7]], [[3, 5], [4, 4], [5, 3], [6, 2], [7, 1]]])).to eq(true)
      end
    end

    context "when a piece is between start and finish" do
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [2, 6], finish_coordinates: [6, 2]) }

      let(:players_piece) { instance_double(Pawn) }

      before do
        chess.board[4][3] = players_piece
      end

      it 'returns false' do
        expect(queen_antediagonals.space_between_antediagonals?(chess, [[[1, 7]], [[3, 5], [4, 4], [5, 3], [6, 2], [7, 1]]])).to eq(false)
      end
    end

    context 'when x-coordinate of start is greater than finish' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [6, 2], finish_coordinates: [2, 6]) }

      let(:players_piece) { instance_double(Pawn) }

      it 'returns true when space between' do
        expect(queen_antediagonals.space_between_antediagonals?(chess, [[[3, 5], [4, 4], [5, 3], [6, 2]], [7, 1], [[1, 7]]] )).to eq(true)
      end

      it 'returns false when piece in the way' do
        chess.board[4][3] = players_piece
        expect(queen_antediagonals.space_between_antediagonals?(chess, [[[3, 5], [4, 4], [5, 3], [6, 2]], [7, 1], [[1, 7]]] )).to eq(false)
      end
    end
  end

  describe 'space_between_columns' do
    subject(:rook_row) { described_class.new(player_one) }
  
    let(:chess) { instance_double(Board, board: [
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', 'Rook', '', '', '', '', 'Target', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '']
    ], start_coordinates: [2, 5], finish_coordinates: [7, 5]) }

    let(:pawn) { instance_double(Pawn) }
    
    context 'when space between rook and target piece is empty' do
      it 'returns true' do
        expect(rook_row.space_between_row?(chess)).to eq(true)
      end
    end

    context 'when space between rook and target piece is not empty' do

      before do 
        chess.board[3][3] = pawn
      end

      it 'returns false' do
        expect(rook_row.space_between_row?(chess)).to eq(false)
      end
    end
  end

  describe '#transpose_column' do
    subject(:rook_transpose) { described_class.new(player_one) }
    let(:chess) { instance_double(Board, board: [
      ['', '0', '', '', '', '', '', ''],
      ['', '1', '', '', '', '', '', ''],
      ['', '2', '', '', '', '', '', ''],
      ['', '3', '', '', '', '', '', ''],
      ['', '4', '', '', '', '', '', ''],
      ['', '5', '', '', '', '', '', ''],
      ['', '6', '', '', '', '', '', ''],
      ['', '7', '', '', '', '', '', '']
    ], start_coordinates: [2, 7]) }
    
    context 'when the board is a transposed' do
      it 'returns column as row' do
        expect(rook_transpose.transpose_column(chess)).to eq(['0', '1', '2', '3', '4', '5', '6', '7'])
      end
    end
  end

  describe '#space_between_column' do
    subject(:queen_column) { described_class.new(player_one) }
    let(:pawn) { instance_double(Pawn) }

    context 'when there is space between rook and target piece' do

    let(:chess) { instance_double(Board, board: [
      ['1', '3', '2', '', '', '', '', ''],
      ['1', 'Rook', '2', '', '', '', '', ''],
      ['1', '', '2', '', '', '', '', ''],
      ['1', '', '2', '', '', '', '', ''],
      ['1', '', '2', '', '', '', '', ''],
      ['1', '', '2', '', '', '', '', ''],
      ['1', 'Pawn', '2', '', '', '', '', ''],
      ['1', '3', '2', '', '', '', '', ''] ], 
      start_coordinates: [2, 2], 
      finish_coordinates: [2, 7], 
      start_square: 'Rook', 
      finish_square: 'Pawn') }
  
      it 'return true' do
        expect(queen_column.space_between_column?(chess)).to eq(true)
      end
    end

    context 'when there is a piece between rook and target piece' do

      let(:chess) { instance_double(Board, board: [
        ['1', '3', '2', '', '', '', '', ''],
        ['1', 'Rook', '2', '', '', '', '', ''],
        ['1', '', '2', '', '', '', '', ''],
        ['1', '', '2', '', '', '', '', ''],
        ['1', '', '2', '', '', '', '', ''],
        ['1', '', '2', '', '', '', '', ''],
        ['1', 'Pawn', '2', '', '', '', '', ''],
        ['1', '3', '2', '', '', '', '', ''] ], 
        start_coordinates: [2, 2], 
        finish_coordinates: [2, 7], 
        start_square: 'Rook', 
        finish_square: 'Pawn') }

      before do 
        chess.board[3][1] = pawn
      end

      it 'return false' do
        expect(queen_column.space_between_column?(chess)).to eq(false)
      end
    end

    context ' when Rook is is moving up the board NOT down' do
      let(:chess) { instance_double(Board, board: [
        ['1', '3', '2', '', '', '', '', ''],
        ['1', 'Pawn', '2', '', '', '', '', ''],
        ['1', '', '2', '', '', '', '', ''],
        ['1', '', '2', '', '', '', '', ''],
        ['1', '', '2', '', '', '', '', ''],
        ['1', '', '2', '', '', '', '', ''],
        ['1', 'Rook', '2', '', '', '', '', ''],
        ['1', '3', '2', '', '', '', '', ''] ], 
        start_coordinates: [2, 7], 
        finish_coordinates: [2, 2], 
        start_square: 'Rook', 
        finish_square: 'Pawn') }

      it 'returns true when path is clear' do
        expect(queen_column.space_between_column?(chess)).to eq(true)
      end

      it 'returns false when path is obstructed' do
        chess.board[3][1] = 'TEST'
        expect(queen_column.space_between_column?(chess)).to eq(false)
      end

    end
  end

  describe 'space_between_rows' do
    subject(:queen_row) { described_class.new(player_one) }
    let(:chess) { instance_double(Board, board: [
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', 'Rook', '', '', '', '', 'Target', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '']
    ], start_coordinates: [2, 5], finish_coordinates: [7, 5]) }

    let(:pawn) { instance_double(Pawn) }
    
    context 'when space between rook and target piece is empty' do
      it 'returns true' do
        expect(queen_row.space_between_row?(chess)).to eq(true)
      end
    end

    context 'when space between rook and target piece is not empty' do

      before do 
        chess.board[3][3] = pawn
      end

      it 'returns false' do
        expect(queen_row.space_between_row?(chess)).to eq(false)
      end
    end
  end

  describe '#transpose_column' do
    subject(:queen_transpose) { described_class.new(player_one) }
    let(:chess) { instance_double(Board, board: [
      ['', '0', '', '', '', '', '', ''],
      ['', '1', '', '', '', '', '', ''],
      ['', '2', '', '', '', '', '', ''],
      ['', '3', '', '', '', '', '', ''],
      ['', '4', '', '', '', '', '', ''],
      ['', '5', '', '', '', '', '', ''],
      ['', '6', '', '', '', '', '', ''],
      ['', '7', '', '', '', '', '', '']
    ], start_coordinates: [2, 7]) }
    
    context 'when the board is a transposed' do
      it 'returns column as row' do
        expect(queen_transpose.transpose_column(chess)).to eq(['0', '1', '2', '3', '4', '5', '6', '7'])
      end
    end
  end
end