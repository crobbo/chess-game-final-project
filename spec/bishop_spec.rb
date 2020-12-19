require 'rspec/autorun'
require_relative '../lib/player'
require_relative '../lib/board'

describe Bishop do

  let(:player_one) { instance_double(Player)}
  let(:player_two) { instance_double(Player)}

  describe '#valid_move?' do
  end

  describe '#possible_moves' do
  end

  describe '#find_diagonals' do
    subject(:bishop_diags) { described_class.new(player_one) }
    let(:chess) { instance_double(Board, start_coordinates: [2, 3], finish_coordinates: [7, 8]) }

    before do
      allow(bishop_diags).to receive(:diag_left_loop).and_return([[1, 2]])
      allow(bishop_diags).to receive(:diag_right_loop).and_return([[3, 4], [4, 5], [5, 6], [6, 7], [7, 8]])
    end
    
    context 'when find_diagonals is called' do
      it 'returns a nested array of all possible diagonal moves' do
        expect(bishop_diags.find_diagonals(chess)).to eq([[[1, 2]], [[3, 4], [4, 5], [5, 6], [6, 7], [7, 8]] ])
      end
    end
  end

  describe '#find_antediagonals' do
    context 'when find_antedigonals is called' do
      xit 'returns an array of all possible diagonal moves' do
      end
    end
  end

  describe '#space_between_diagonals' do
    context 'when there a players own piece between start and finish' do
    end

    context 'when there is clear space between start and finish' do
    end

    context 'when there is an opponents piece between between start and finish' do
    end
  end

  describe '#space_between_antediagonals' do
    context 'when there a players own piece between start and finish' do
    end

    context 'when there is clear space between start and finish' do
    end

    context 'when there is an opponents piece between between start and finish' do
    end
  end

  describe 'diag_left_loop' do
    subject(:left_diags) { described_class.new(player_one)}

    context 'when start coordinates are inputted' do
      it 'returns a single array' do
        expect(left_diags.diag_left_loop([2, 3])).to contain_exactly([1, 2])
      end
      it 'returns an array of the diagonals' do
        expect(left_diags.diag_left_loop([4, 7])).to contain_exactly([3, 6], [2, 5], [1, 4])
      end
    end
  end

  describe 'diag_right_loop' do
    subject(:right_diags) { described_class.new(player_one)}

    context 'when start coordinates are inputted' do
      it 'returns a single array' do
        expect(right_diags.diag_right_loop([2, 3])).to contain_exactly([3, 4], [4, 5], [5, 6], [6, 7], [7, 8])
      end
      it 'returns an array of the diagonals' do
        expect(right_diags.diag_right_loop([4, 7])).to contain_exactly([5, 8])
      end
    end
  end
end
