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

  describe '#find_king' do
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

    describe '#king_first_move?' do
      context 'King is yet to move' do
        subject(:king_move) { described_class.new }
        let(:king) { instance_double(King, which_player: player_one, type: 'King', first_move: true) }

        it 'returns true' do
          expect(king_move.king_first_move?(king)).to eq(true)
        end
      end

      context 'King has moved previously' do
        subject(:king_move) { described_class.new }
        let(:king) { instance_double(King, which_player: player_one, type: 'King', first_move: false) }

        it 'returns false' do
          expect(king_move.king_first_move?(king)).to eq(false)
        end
      end
    end

    describe '#rook_first_move?' do
      context 'Rook is yet to move' do
        subject(:rook_move) { described_class.new }
        let(:rook) { instance_double(Rook, which_player: player_one, type: 'Rook', first_move: true) }

        it 'returns true' do
          expect(rook_move.rook_first_move?(rook)).to eq(true)
        end
      end

      context 'King has moved previously' do
        subject(:rook_move) { described_class.new }
        let(:rook) { instance_double(Rook, which_player: player_one, type: 'Rook', first_move: false) }

        it 'returns false' do
          expect(rook_move.king_first_move?(rook)).to eq(false)
        end
      end
    end

    describe '#return_rook' do
      context "Rook1 hasn't moved yet, Rook2 has moved" do
        subject(:rook1_not_moved) { described_class.new }
        let(:rook_one) { instance_double(Rook, which_player: player_one, type: 'Rook', first_move: true) }
        let(:rook_two) { instance_double(Rook, which_player: player_one, type: 'Rook', first_move: false) }
        let(:board) { [
          [rook_one, '', '', '', '', '', '', '',
          ['', '', '', '', '', '', '', rook_two]],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ] }

        before do
          rook1_not_moved.instance_variable_set("@rook1", rook_one)
          rook1_not_moved.instance_variable_set("@rook2", rook_two)
        end

        it 'returns rook 1' do
          expect(rook1_not_moved.return_rook(board, player_one)).to eq(rook_one)
        end
      end

      context "Rook1 has moved, Rook2 hasn't moved yet" do
        subject(:rook2_not_moved) { described_class.new }
        let(:rook_one) { instance_double(Rook, which_player: player_one, type: 'Rook', first_move: false) }
        let(:rook_two) { instance_double(Rook, which_player: player_one, type: 'Rook', first_move: true) }
        let(:board) { [
          ['', '', '', '', '', '', '', rook_two,
          [rook_one, '', '', '', '', '', '', '']],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ] }

        before do
          rook2_not_moved.instance_variable_set("@rook1", rook_one)
          rook2_not_moved.instance_variable_set("@rook2", rook_two)
        end

        it 'returns rook 2' do
          expect(rook2_not_moved.return_rook(board, player_one)).to eq(rook_two)
        end
      end

      context "Both Rooks have already moved" do
        subject(:rooks_both_moved) { described_class.new }
        let(:rook_one) { instance_double(Rook, which_player: player_one, type: 'Rook', first_move: false) }
        let(:rook_two) { instance_double(Rook, which_player: player_one, type: 'Rook', first_move: false) }
        let(:board) { [
          ['', '', '', '', '', '', '', '',
          [rook_one, '', '', '', '', '', '', rook_two]],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ] }

        before do
          rooks_both_moved.instance_variable_set("@rook1", rook_one)
          rooks_both_moved.instance_variable_set("@rook2", rook_two)
        end

        it 'returns rook 2' do
          expect(rooks_both_moved.return_rook(board, player_one)).to eq(false)
        end
      end
    end

    describe '#empty_squares?' do
      context 'All squares empty between Rook and King' do
        subject(:spaces_between) { described_class.new }
        let(:board) { [
          [rook_1a, '', '', king_1, '', '', '', '',
          ['', '', '', '', '', '', '', '']],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ] }

        it 'returns true' do
          expect(spaces_between.empty_squares?(board, player_one, rook_1a, king_1)).to eq(true)
        end
      end

      context 'All squares empty between Rook and King' do
        subject(:spaces_between) { described_class.new }
        let(:board) { [
          ['', '', '', king_1, '', '', '', rook_1b],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ] }

        it 'returns true' do
          expect(spaces_between.empty_squares?(board, player_one, rook_1b, king_1)).to eq(true)
        end
      end

      context 'Not all squares empty between Rook and King' do
        subject(:spaces_between) { described_class.new }
        let(:board) { [
          [rook_1a, 'PAWN', '', king_1, '', '', '', '',
          ['', '', '', '', '', '', '', '']],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ] }

        it 'returns false' do
          expect(spaces_between.empty_squares?(board, player_one, rook_1a, king_1)).to eq(false)
        end
      end

      context 'Not all squares empty between Rook and King' do
        subject(:spaces_between) { described_class.new }
        let(:board) { [
          ['', '', '', king_1, '', 'PAWN', '', rook_1b],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ] }

        it 'returns false' do
          expect(spaces_between.empty_squares?(board, player_one, rook_1b, king_1)).to eq(false)
        end
      end
    end

    describe '#find_coordinates' do
      context 'Piece is on the board' do
        subject(:castling_coordinates) { described_class.new }
        let(:board) { [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '',  pawn_2a, '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', pawn_1b, pawn_1a, '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ] }

        it 'returns coordinates' do
          expect(castling_coordinates.find_coordinates(board, pawn_1a)).to eq([4, 4])
        end
      end

      context 'Piece is on the board' do
        subject(:castling_coordinates) { described_class.new }
        let(:board) { [
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '',  pawn_2a, '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', pawn_1b, '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          [pawn_1a, '', '', '', '', '', '', '']
        ] }

        it 'returns coordinates' do
          expect(castling_coordinates.find_coordinates(board, pawn_1a)).to eq([1, 1])
        end
      end
    end

    # describe '#which_sqaures'
end