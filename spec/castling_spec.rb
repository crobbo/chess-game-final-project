require 'rspec/autorun'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/pawn'
require_relative '../lib/board'
require 'pry'

# let(:board) { [[rook_1a, '', '', king_1, '', '', '', ''],
#   ['', '', pawn_1a, pawn_1b, '', '', '', rook_1b],
#   ['', '', '', '', '', '', '', ''],
#   ['', '', '', '', '', '', '', ''],
#   ['', '', pawn_2a, pawn_2b, '', '', '', ''],
#   ['', '', '', '', '', '', '', rook_2a],
#   [rook_1a, '', '', '', '', '', '', ''],
#   ['', '', '', '', '', king_2, '', '']] }

describe Castling do

  let(:player_one) { instance_double(Player, data: {name: 'Amy', number: 1}) }
  let(:player_two) { instance_double(Player, data: {name: 'Christian', number: 2}) }

  let(:pawn_1a) { instance_double(Pawn, which_player: player_one, type: 'Pawn') }
  let(:pawn_1b) { instance_double(Pawn, which_player: player_one, type: 'Pawn') }
  let(:rook_1a) { instance_double(Rook, which_player: player_one, type: 'Rook') }
  let(:rook_1b) { instance_double(Rook, which_player: player_one, type: 'Rook') }
  let(:king_1) { instance_double(King, which_player: player_one, type: 'King') }
  
  let(:pawn_2a) { instance_double(Pawn, which_player: player_two, type: 'Pawn') }
  let(:pawn_2b) { instance_double(Pawn, which_player: player_two, type: 'Pawn') }
  let(:rook_2a) { instance_double(Rook, which_player: player_two, type: 'Rook') }
  let(:rook_2b) { instance_double(Rook, which_player: player_two, type: 'Rook') }
  let(:king_2) { instance_double(King, which_player: player_two, type: 'King') }

  describe 'find_king' do
    context 'When Player 1 King is on the board and Player 1 searching' do
      subject(:king_on_board) { described_class.new }

      let(:board) { [
        ['', '', king_1, '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ] }

      it 'returns true' do
        king_on_board.find_king(board, player_one)
        expect(king_on_board.instance_variable_get(:@king)).to eq(king_1)
      end
    end

    context 'Player 2 King is on the board and Player 1 searching' do
      subject(:king_on_board) { described_class.new }

      let(:board) { [
        ['', '', king_2, '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ] }

      it 'returns nil' do
        king_on_board.find_king(board, player_one)
        expect(king_on_board.instance_variable_get(:@king)).to eq(nil)
      end
    end

    context 'Player 1 & Player 2 King when is on the board and Player 1 searching' do
      subject(:king_on_board) { described_class.new }

      let(:board) { [
        ['', '', king_2, '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', king_1, '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ] }

      it 'returns true' do
        king_on_board.find_king(board, player_one)
        expect(king_on_board.instance_variable_get(:@king)).to eq(king_1)
      end
    end
  end

  describe '#find_rook' do
    context "Finds first Rook when Player 1's Rooks are on the board" do
      subject(:rook_on_board) { described_class.new }

      let(:board) { [
        [rook_1a, '', '', '', '', '', '', rook_1b],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ] }

      it 'returns true' do
        rook_on_board.find_rook(board, player_one)
        expect(rook_on_board.instance_variable_get(:@rook1)).to eq(rook_1a)
      end
    end
    context "Finds first Rook when Player 1's Rooks are on the board" do
      subject(:rook_on_board) { described_class.new }

      let(:board) { [
        [rook_1a, '', '', '', '', '', '', rook_1b],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ] }

      it 'returns true' do
        rook_on_board.find_rook(board, player_one)
        expect(rook_on_board.instance_variable_get(:@rook2)).to eq(rook_1b)
      end
    end
  end
end