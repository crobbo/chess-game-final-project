require 'rspec/autorun'
require_relative '../lib/player'
require_relative '../lib/board'

describe Bishop do
  describe '#valid_move?' do
  end

  describe '#possible_moves' do
  end

  describe '#find_diagonals' do
    context 'when find_digonals is called' do
      xit 'returns an array of all possible diagonal moves' do
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
    let(:player_one) { instance_double(Player)}
    let(:player_two) { instance_double(Player)}
    subject(:left_diags) { described_class.new(player_one)}

    context 'when start coordinates are inputted' do
      it 'returns an array of the diagonals' do
        expect(left_diags.diag_left_loop([2, 3])).to contain_exactly([1, 2])
      end
    end

    context 'when start coordinates are inputted' do
      xit 'returns an array of the diagonals' do
      end
    end

  end
end
