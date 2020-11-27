require 'rspec/autorun'
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/pawn'

describe Pawn do

  let(:player_one) { instance_double(Player)}
  let(:player_two) { instance_double(Player)}

  describe '#player_one_moves' do
    # possible moves may not all be valid moves
    
    context "Player 1 Pawn is making it's first move" do
      
      subject(:pawn_one) { described_class.new(player_one) }
      let(:start_coordinates) { [4, 7] }


      it 'returns array length of 2' do
        expect(pawn_one.player_one_moves(start_coordinates).length).to eq(2)
      end

      it 'returns array containing 2 diagonal moves' do
        expect(pawn_one.player_one_moves(start_coordinates)[0]). to contain_exactly([5, 6], [3, 6])
      end

      it 'returns array containing 2 forward moves' do
        expect(pawn_one.player_one_moves(start_coordinates)[1]). to contain_exactly([4, 6], [4, 5])
      end
    end
  end 

  describe '#player_two_moves' do 

    subject(:pawn_two) { described_class.new(player_two) }
    let(:start_coordinates) { [5, 2] }

    context "Player 2 Pawn is making it's first move" do
      it 'returns array length of 2' do
        expect(pawn_two.player_two_moves(start_coordinates).length).to eq(2)
      end

      it 'returns array containing 2 diagonal moves' do
        expect(pawn_two.player_two_moves(start_coordinates)[0]). to contain_exactly([6, 3], [4, 3])
      end

      it 'returns array containing 2 forward moves' do
        expect(pawn_two.player_two_moves(start_coordinates)[1]). to contain_exactly([5, 3], [5, 4])
      end 
    end

  end

  describe '#possilbe_moves'do
    
    context "when it's player one's turn" do
      
      subject(:pawn_moves) { described_class.new(player_one) }

      before do
        allow(player_one).to receive(:data).and_return({ number: 1})
        allow(pawn_moves).to receive(:player_one_moves).and_return('player_one_moves')
      end

      it 'returns #player_one_moves' do
        expect(pawn_moves.possible_moves([5, 7], player_one)).to eq('player_one_moves')
      end
    end

    context "when it's player two's turn" do 

      subject(:pawn_moves) { described_class.new(player_two) }
      
      before do
        allow(player_two).to receive(:data).and_return({ number: 2})
        allow(pawn_moves).to receive(:player_two_moves).and_return('player_two_moves')        
      end

      it 'returns #player_two_moves' do
        expect(pawn_moves.possible_moves([2,2], player_two)).to eq('player_two_moves')
      end
    end
  end


  describe '#valid_moves?' do
    context 'when Player 1 pawn is moving to an empty forward square on first go' do
      xit 'returns true moving distance of 1' do
      end

      xit 'returns true when moving distance of 2' do
      end

      xit 'returns false when movin distance of 3' do
      end
    end

    context 'when player 1 pawn is moving to an empty forward square on second move' do
      xit 'returns true moving distance of 1' do
      end

      xit 'returns false when moving distance of 2' do
      end

      xit 'returns false when movin distance of 3' do
      end
    end

    context 'when player 1 pawn is moving to an empty diagonal square' do
      
      xit 'returns false when moving to left diagonal' do
      end

      xit 'returns false when moving to right diagonal' do
      end
    end
  end
end
