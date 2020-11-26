require 'rspec/autorun'
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/pawn'

describe Pawn do

  describe '#possible_moves' do
    # possible moves may not all be valid moves

    context "Player 1 Pawn is making it's first move" do
      xit 'returns array length of 2' do
      end

      xit 'returns nested array of diagonals and forwards moves' do
      end

      xit 'returns array containing 2 diagonal moves' do
      end

      xit 'returns array containing 2 forward moves' do
      end
    end 

    context "Player 2 Pawn is making it's first move" do
      xit 'returns array length of 2' do
      end

      xit 'returns nested array of diagonals and forwards moves' do
      end

      xit 'returns array containing 2 diagonal moves' do
      end

      xit 'returns array containing 2 forward moves' do
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
