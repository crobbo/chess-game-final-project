require 'rspec/autorun'
require_relative '../lib/player'
require_relative '../lib/rook'
require_relative '../lib/board'

describe Rook do

  let(:player_one) { instance_double(Player)}
  let(:player_two) { instance_double(Player)}

  describe '#valid_move?' do
    subject(:rook_valid) { described_class.new(player_one) }

    context 'when rook is moving to square not on the same axis' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [1, 7], finish_coordinates: [2, 5]) }

      before do
        allow(rook_valid).to receive(:same_axis?).and_return(false)
      end

      it 'returns false' do
        expect(rook_valid.valid_move?(chess, player_one)).to eq(false)
      end
    end

    context 'when rook is moving to an empty square in the same column' do
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [4, 4], finish_coordinates: [4, 7], start_square: rook_valid, finish_square: '') }

      before do 
        chess.board[4][3] = rook_valid
      end

      it 'returns true' do
        expect(rook_valid.valid_move?(chess, player_one)).to eq(true)
      end
    end

    context 'when rook is moving to an empty square on the same row' do
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [4, 4], finish_coordinates: [7, 4], start_square: rook_valid, finish_square: '') }

      before do 
        chess.board[4][3] = rook_valid
      end

      it 'returns true' do
        expect(rook_valid.valid_move?(chess, player_one)).to eq(true)
      end
    end

    context "when rook is moving to a square occupied by player's own piece on the same row" do
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [4, 4], finish_coordinates: [7, 4], start_square: rook_valid, finish_square: pawn) }
      
      let(:pawn) { instance_double(Pawn, which_player: player_one)}

      before do 
        chess.board[4][3] = rook_valid
        chess.board[4][6] = pawn
      end

      it 'returns false' do
        expect(rook_valid.valid_move?(chess, player_one)).to eq(false)
      end
    end

    context "when rook is moving to a square occupied by player's own piece in the same column" do
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [4, 4], finish_coordinates: [4, 8], start_square: rook_valid, finish_square: pawn) }
      
      let(:pawn) { instance_double(Pawn, which_player: player_one)}

      before do 
        chess.board[4][3] = rook_valid
        chess.board[0][3] = pawn
      end

      it 'returns false' do
        expect(rook_valid.valid_move?(chess, player_one)).to eq(false)
      end
    end

    context "when rook is moving to a square occupied by opponent's piece" do
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [4, 4], finish_coordinates: [4, 8], start_square: rook_valid, finish_square: pawn) }
      
      let(:pawn) { instance_double(Pawn, which_player: player_two)}

      before do 
        chess.board[4][3] = rook_valid
        chess.board[0][3] = pawn
      end
      
      it 'returns true' do
        expect(rook_valid.valid_move?(chess, player_one)).to eq(true)
      end
    end

  end

  describe '#same_axis??' do

    subject(:rook_axis) { described_class.new(player_one) }

    context 'when rook is selected to move to a target sqaure' do
      it 'returns true if start_sqaure and finish_square are on the same x-axis' do
        start_coordinates = [2, 3]
        finish_coordinates = [2, 8]
        expect(rook_axis.same_axis?(start_coordinates, finish_coordinates)).to eq(true)
      end

      it 'returns true if start_sqaure and finish_square are on the same y-axis' do
        start_coordinates = [4, 8]
        finish_coordinates = [2, 8]
        expect(rook_axis.same_axis?(start_coordinates, finish_coordinates)).to eq(true)
      end

      it 'returns false if start_sqaure and finish_square are on NOT the same x-axis' do
        start_coordinates = [2, 3]
        finish_coordinates = [1, 6]
        expect(rook_axis.same_axis?(start_coordinates, finish_coordinates)).to eq(false)
      end
    end
  end

  describe '#possible_moves' do
    subject(:rook_moves) { described_class.new(player_one) }

    context 'when player wants to move the rook' do

      before do
        allow(rook_moves).to receive(:find_row_squares).and_return([[1, 3], [2, 3], [3, 3]])
        allow(rook_moves).to receive(:find_column_squares).and_return([[4, 1], [4, 2]])
      end

      it 'returns a nested array of possible moves' do
        start_coordinates = [4, 3]
        expect(rook_moves.possible_moves(start_coordinates)).to eq([[[1, 3], [2, 3], [3, 3]], [[4, 1], [4, 2]]])
      end
    end
  end

  describe '#find_row_squares' do

    subject (:rook_row) { described_class.new(player_one)}

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
        expect(rook_row.possible_moves(chess.start_coordinates)[0]).to contain_exactly([2, 2], [3, 2], [4, 2], [5, 2], [6, 2], [7, 2], [8, 2])
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
        expect(rook_row.possible_moves(chess.start_coordinates)[0]).to contain_exactly([1, 4], [2, 4], [3, 4], [4, 4], [6, 4], [7, 4], [8, 4])
      end

    end
  end

  describe '#find_column_squares' do

    subject (:rook_column) { described_class.new(player_one)}

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
        expect(rook_column.possible_moves(chess.start_coordinates)[1]).to contain_exactly([1, 1], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8])
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
        expect(rook_column.possible_moves(chess.start_coordinates)[1]).to contain_exactly([5, 1], [5, 2], [5, 3], [5, 5], [5, 6], [5, 7], [5, 8])
      end

    end
  end

  describe '#space_between_row' do
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
    subject(:rook_column) { described_class.new(player_one) }
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
        expect(rook_column.space_between_column?(chess)).to eq(true)
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
        expect(rook_column.space_between_column?(chess)).to eq(false)
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
        expect(rook_column.space_between_column?(chess)).to eq(true)
      end

      it 'returns false when path is obstructed' do
        chess.board[3][1] = 'TEST'
        expect(rook_column.space_between_column?(chess)).to eq(false)
      end

    end
  end
end



