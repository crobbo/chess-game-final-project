require 'rspec/autorun'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/knight'

describe Knight do
  
  subject(:knight) { described_class.new(player_one) }
  let(:player_one) { instance_double(Player) }
  let(:player_two) { instance_double(Player) }

  describe '#valid_move?' do

    context 'when player moves knight to empty square' do

      let(:board) { instance_double(Board, start_coordinates: [1,1], finish_coordinates: [3, 2], board: [ ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ]) }

      before do
        board.board[7][0] = knight
      
      end

      it 'returns true' do
        expect(knight.valid_move?(board, player_one)).to eq(true)
      end
      
    end

    context 'when player moves piece to a square occupied by their opponents piece' do

      let(:opponents_piece) { instance_double(Pawn, which_player: player_two) }

      let(:board) { instance_double(Board, start_coordinates: [1, 1], finish_coordinates: [3, 2], board: [ ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ]) }

      before do
        board.board[7][0] = knight
        board.board[6][2] = opponents_piece
      end

      it 'returns true' do
        expect(knight.valid_move?(board, player_one)).to eq(true)
      end
    end

    context 'when player moves piece to square occupied by their own piece' do

      let(:players_pawn) { instance_double(Pawn, which_player: player_one) }

      let(:board) { instance_double(Board, start_coordinates: [1, 1], finish_coordinates: [3, 2], board: [ ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ]) }

      before do
        board.board[7][0] = knight
        board.board[6][2] = players_pawn
      end

      it 'returns false' do
        expect(knight.valid_move?(board, player_one)).to eq(false)
      end
    end

    context 'when player moves piece to square which a knight move cannot make' do

      let (:board) { instance_double(Board, start_coordinates: [1,1], finish_coordinates: [1, 2], board: [ ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ]) }

      before do
        board.board[7][0] = knight
      end

      it 'returns false' do
        expect(knight.valid_move?(board, player_one)).to eq(false)
      end
    end

  end


  describe '#possible_moves' do
    context 'when a knight has 8 valid moves' do

      let(:board) { instance_double(Board, start_coordinates: [4, 4]) }

      it 'returns an array of 8 valid moves' do
        expect(knight.possible_moves(board.start_coordinates)).to contain_exactly([3, 2], [5, 2], [6, 3], [6, 5], [5, 6], [3, 6], [2, 5], [2, 3])
      end
    end

    context 'when a knight is on the edge of the board' do
      
      let(:board) { instance_double(Board, start_coordinates: [1, 4]) }

      it 'returns an array of valid moves' do
        expect(knight.possible_moves(board.start_coordinates)).to include([2, 6], [3, 5], [3, 3], [2, 2])
      end
    end

    context 'when a knight is in the corner of the board' do

      let(:board) { instance_double(Board, start_coordinates: [1, 1]) }

      it 'returns an array of possible moves' do
        expect(knight.possible_moves(board.start_coordinates)).to include([3, 2], [2, 3])
      end
    end
  end
end