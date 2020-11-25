require 'rspec/autorun'
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'

describe Pawn do

  describe '#possible_moves' do
    # possible moves may not be valid moves
    
    subject(:pawn) { described_class.new(player_two) }
    let(:player_one) { instance_double(Player) }
    let(:player_two) { instance_double(Player) }

    context "when Pawn is making it's first move" do
      
      let(:board) { instance_double(Board, start_coordinates: [4, 2], board: [ ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ]) }

      before do 
       board.board[6][5] = pawn
       allow(player_two).to receive(:data).and_return({ number: 2 })
      end

      it ' returns array of possible moves' do
        expect(pawn.possible_moves(board.start_coordinates, player_two)).to contain_exactly([4,3], [4, 4], [3, 3], [5, 3])
      end
    end

    context "when Pawn is making a move that is not it's first move" do
      
      let(:board) { instance_double(Board, start_coordinates: [4, 3], board: [ ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ]) }

      before do
        subject.instance_variable_set(:@first_move, false)
        allow(player_two).to receive(:data).and_return({ number: 2 })
      end
      it 'returns array of possible moves but excludes 2 moves forward' do
        expect(pawn.possible_moves(board.start_coordinates, player_two)).to contain_exactly([3, 4], [4, 4], [5, 4])
      end
    end

    context "when a pawn is making it's first move" do

      xit 'first_move returns true' do
      end
    end

    context "when a pawn is making it's second move" do
      xit 'first_move returns false' do
      end
    end
  end
end
