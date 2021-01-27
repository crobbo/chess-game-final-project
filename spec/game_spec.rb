require 'rspec/autorun'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/pawn'
require_relative '../lib/board'


describe Game do
  let(:player_one) { instance_double(Player) }
  let(:player_two) { instance_double(Player) }

  let(:rook) { instance_double(Rook, which_player: player_one, type: 'Rook') }
  let(:bishop) { instance_double(Bishop, which_player: player_one, type: 'Bishop') }
  let(:pawn) { instance_double(Pawn, which_player: player_one, type: 'Pawn') }
  let(:king) { instance_double(King, which_player: player_two, type: 'King') }
  
  let(:queen2) { instance_double(Queen, which_player: player_two, type: 'Queen') }
  let(:queen1) { instance_double(Queen, which_player: player_one, type: 'Queen') }
  let(:bishop2) { instance_double(Bishop, which_player: player_two, type: 'Bishop') }
  let(:pawn1) { instance_double(Pawn, which_player: player_two, type: 'Pawn') }
  let(:pawn2) { instance_double(Pawn, which_player: player_two, type: 'Pawn') } 

  describe '#check?' do

    subject(:game_check) { described_class.new(player_one, player_two, board_class)}

    context 'When rook and bishop have opponents King in Check' do


        let(:board_class) { instance_double(Board, board: [
          ['', '', rook, '', '', '', king, ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', bishop, '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '', '']
        ], start_coordinates: [], finish_coordinates: []) }

        before do
          allow(game_check).to receive(:whos_turn).and_return(player_one)
          allow(board_class).to receive(:start_coordinates=)
          allow(rook).to receive(:valid_move?).and_return(true)
          allow(bishop).to receive(:valid_move?).and_return(true)
        end

        xit 'returns true' do
          expect(game_check.check?([7, 8])).to eq(true)
        end

      end

    context 'When rook and bishop do NOT have opponents King in Check' do

      let(:board_class) { instance_double(Board, board: [
        ['', '', '', '', '', '', king, ''],
        ['', '', rook, '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', bishop, '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [], finish_coordinates: []) }

      before do
        allow(game_check).to receive(:whos_turn).and_return(player_one)
        allow(board_class).to receive(:start_coordinates=)
        allow(rook).to receive(:valid_move?).and_return(false)
        allow(bishop).to receive(:valid_move?).and_return(false)
      end

      xit 'does NOT equal true' do
        expect(game_check.check?([7, 8])).to_not eq(true)
      end

    end
  end

  describe '#checkmate?' do

    subject(:game_checkmate) { described_class.new(player_one, player_two, board_class)}

    context 'when King is NOT checkmate' do

      let(:board_class) { instance_double(Board, board: [
        ['', '', rook, '', '', '', '', king],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', pawn],
        ['', '', '', '', bishop, '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [], finish_coordinates: [8, 8]) }

      before do
        allow(game_checkmate).to receive(:whos_turn).and_return(player_one)
        allow(board_class).to receive(:start_coordinates=)
        allow(rook).to receive(:valid_move?).and_return(true, false, false)
        allow(bishop).to receive(:valid_move?).and_return(false, false, false)
        allow(pawn).to receive(:valid_move?).and_return(false, true, false)
        allow(king).to receive(:possible_moves).and_return([[9, 9], [8, 9], [7, 9], [7, 8], [7, 7], [8, 7], [9, 7], [9, 8]])     
      end

      xit 'returns false' do
        expect(game_checkmate.checkmate?).to eq(false)
      end
    end

    context 'when King is checkmate' do

      let(:board_class) { instance_double(Board, board: [
        ['', '', rook, '', '', '', '', king],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', pawn, ''],
        ['', '', '', '', bishop, '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [], finish_coordinates: [8, 8], start_square: nil, finish_square: nil) }

      before do
        allow(game_checkmate).to receive(:whos_turn).and_return(player_one)
        allow(board_class).to receive(:start_coordinates=)
        allow(rook).to receive(:valid_move?).and_return(true, false, false)
        allow(bishop).to receive(:valid_move?).and_return(false, true, false)
        allow(pawn).to receive(:valid_move?).and_return(false, false, true)
        allow(king).to receive(:possible_moves).and_return([[9, 9], [8, 9], [7, 9], [7, 8], [7, 7], [8, 7], [9, 7], [9, 8]])
        allow(board_class).to receive(:start_square=)
      end

      xit 'returns true' do
        expect(game_checkmate.checkmate?).to eq(true)
      end
    end

    context 'when King is checkmate but can escape by taking opponenets piece' do


      let(:board_class) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', pawn2, queen1, pawn1, '', '', ''],
        ['', '', bishop2, king, queen2, '', '', '']
      ], start_coordinates: [], finish_coordinates: [4, 2], start_square: nil, finish_square: nil) }

      before do
        allow(game_checkmate).to receive(:whos_turn).and_return(player_one)
        allow(board_class).to receive(:start_coordinates=)
        allow(queen1).to receive(:valid_move?).and_return(false)
        allow(king).to receive(:valid_move?).and_return(false, true, false, false, false)
        allow(king).to receive(:possible_moves).and_return([[5, 1], [4, 2], [3, 2], [3, 1], [3, 0], [4, 0], [5, 0], [5, 1]])
        # allow(king).to receive(:possible_moves).and_return([[5, 2], [4, 3], [3, 1], [3, 1], [3, 0], [4, 0], [5, 0], [5, 1]])
        allow(board_class).to receive(:start_square=)

      end

      it 'returns false' do
        expect(game_checkmate.checkmate?).to eq(false)
      end
    end

  end
end
