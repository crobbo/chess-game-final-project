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
    let(:chess) { instance_double(Board, start_coordinates: [2, 3] ) }

    before do
      allow(bishop_diags).to receive(:diag_bottom_left).and_return([[1, 2]])
      allow(bishop_diags).to receive(:diag_top_right).and_return([[3, 4], [4, 5], [5, 6], [6, 7], [7, 8]])
    end

    context 'when find_diagonals is called' do
      it 'returns a nested array of all possible diagonal moves' do
        expect(bishop_diags.find_diagonals(chess)).to eq([[[1, 2]], [[3, 4], [4, 5], [5, 6], [6, 7], [7, 8]] ])
      end
    end
  end

  describe '#find_antediagonals' do
    subject(:bishops_antediags) { described_class(player_one) }
    let(:chess) { instance_double(Board, ) }

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

  describe 'diag_bottom_left' do
    subject(:left_diags) { described_class.new(player_one)}

    context 'when start coordinates are inputted' do
      it 'returns an array of the south-west diagonals' do
        expect(left_diags.diag_bottom_left([2, 3])).to contain_exactly([1, 2])
      end
      it 'returns an array of the south-west diagonals' do
        expect(left_diags.diag_bottom_left([4, 7])).to contain_exactly([3, 6], [2, 5], [1, 4])
      end
    end
  end

  describe 'diag_top_right' do
    subject(:right_diags) { described_class.new(player_one)}

    context 'when start coordinates are inputted' do
      it 'returns an array of the north-east diagonals' do
        expect(right_diags.diag_top_right([2, 3])).to contain_exactly([3, 4], [4, 5], [5, 6], [6, 7], [7, 8])
      end
      it 'returns an array of the north-east diagonals' do
        expect(right_diags.diag_top_right([4, 7])).to contain_exactly([5, 8])
      end
    end
  end

  describe 'diag_top_left' do
    subject(:top_left_diags) { described_class.new(player_one)}

    context 'when start coordinates are inputted' do
      it 'returns an array of the north-west diagonals' do
        expect(top_left_diags.diag_top_left([2, 6])).to contain_exactly([1, 7])
      end
      it 'returns an array of the north-west diagonals' do
        expect(top_left_diags.diag_top_left([5, 5])).to contain_exactly([4, 6], [3, 7], [2, 8]) 
      end
    end
  end

  describe 'diag_bottom_right' do
    subject(:bottom_right_diags) { described_class.new(player_one)}

    context 'when start coordinates are inputted' do
      it 'returns an array of the south-east diagonals' do
        expect(bottom_right_diags.diag_bottom_right([1, 2])).to contain_exactly([2, 1])
      end
      it 'returns an array of the south-east diagonals' do
        expect(bottom_right_diags.diag_bottom_right([3, 3])).to contain_exactly([4, 2], [5, 1])
      end
    end
  end
end
