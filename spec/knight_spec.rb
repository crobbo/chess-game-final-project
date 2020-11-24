require 'rspec/autorun'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/knight'

describe Knight do

  describe '#valid_move?' do
    # this is the method I am trying to test
    let(:player_one) { instance_double(Player(1)) }
    let(:player_two) { instance_double(Player(2)) }
    let(:board) { instance_double(Board) }
    subject(:knight) { described_class.new(player_one) }

    context 'when player moves knight to empty square' do
     
      before do
        allow(board).to receive(:start_coordinates).with([1, 1])
        allow(board).to receive(:finish_coordinates).with([3, 2])
        board[7][0] = knight
        board[5][1] = ''
      end
    
      it 'returns true' do
        expect(knight.valid_move?).to eq(true)
      end
      
    end

    context 'when player moves piece to square occupied by their own piece' do
      xit 'returns true' do

      end
    end

    context 'when player moves piece to square occupied by their own piece' do
      xit 'returns false' do

      end
    end

    context 'when player moves piece to square which a knight move cannot make' do
      xit 'returns false' do 

      end
    end

  end
end