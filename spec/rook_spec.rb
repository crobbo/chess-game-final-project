require 'rspec/autorun'
require_relative '../lib/player'
require_relative '../lib/rook'
require_relative '../lib/board'

describe Rook do

  let(:player_one) { instance_double(Player)}
  let(:player_two) { instance_double(Player)}

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
end



