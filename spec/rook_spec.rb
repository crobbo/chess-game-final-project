require 'rspec/autorun'
require_relative '../lib/player'
require_relative '../lib/rook'
require_relative '../lib/board'

describe Rook do

  let(:player_one) { instance_double(Player)}
  let(:player_two) { instance_double(Player)}

  describe '#valid_move?' do
  end

  describe '#possible_moves' do
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
    subject(:rook_path) { described_class.new(player_one) }
  
    let(:chess) { instance_double(Board, board: [
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '']
    ], start_coordinates: [2, 5], finish_coordinates: [7, 5]) }

    let(:pawn) { instance_double(Pawn) }
    
    context 'when space between rook and target piece is is empty' do
      it 'returns true' do
        expect(rook_path.space_between_row?(chess)).to eq(true)
      end
    end

    context 'when space between rook and target piece is not empty' do

      before do 
        chess.board[3][3] = pawn
      end

      it 'returns false' do
        expect(rook_path.space_between_row?(chess)).to eq(false)
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
    
    context 'when a board is a transposed' do
      it 'returns column as row' do
        expect(rook_transpose.transpose_column(chess)).to eq(['0', '1', '2', '3', '4', '5', '6', '7'])
      end
    end
  end

  describe '#space_between_column' do
    subject(:rook_path) { described_class.new(player_one) }
  
    let(:chess) { instance_double(Board, board: [
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '']
    ], start_coordinates: [2, 7], finish_coordinates: [2, 1]) }

    let(:pawn) { instance_double(Pawn) }
    
    context 'when #space_between_row is called' do
      xit 'returns an array moves' do
      end
    end
  end
end



