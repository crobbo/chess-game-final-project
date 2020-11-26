require 'rspec/autorun'
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/pawn'

describe Pawn do

  describe '#possible_moves' do
    # possible moves may not all be valid moves
  
    let(:player_one) { instance_double(Player) }
    let(:player_two) { instance_double(Player) }

    context "when Player 1 Pawn is making it's first move" do

      subject(:pawn_one) { described_class.new(player_one) }

      let(:board) { instance_double(Board, start_coordinates: [4, 7], board: [ ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ]) }

      before do
        board.board[1][3] = pawn_one
        allow(player_one).to receive(:data).and_return({ number: 1 })
      end

      it "returns array of exact moves" do
        expect(pawn_one.possible_moves(board.start_coordinates, player_one)).to contain_exactly([4, 6], [4, 5], [5, 6], [3, 6])
      end

    end

    context "when Player 1 Pawn is making a move that is not it's first move" do
      
      subject(:pawn_one) { described_class.new(player_one) }

      let(:board) { instance_double(Board, start_coordinates: [4, 7], board: [ ['', '', '', '', '', '', '', ''],
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
        allow(player_one).to receive(:data).and_return({ number: 1 })
      end
      it 'returns array of possible moves but excludes a move 2 squares forward' do
        expect(pawn_one.possible_moves(board.start_coordinates, player_one)).to contain_exactly([4, 6], [5, 6], [3, 6])
      end
    end

    context "when Player 2 Pawn is making it's first move" do

      subject(:pawn_two) { described_class.new(player_two) }

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
       board.board[6][5] = pawn_two
       allow(player_two).to receive(:data).and_return({ number: 2 })
      end

      it 'returns array of exact moves' do
        expect(pawn_two.possible_moves(board.start_coordinates, player_two)).to contain_exactly([4,3], [4, 4], [3, 3], [5, 3])
      end
    end

    context "when Player 2 Pawn is making a move that is not it's first move" do
      
      subject(:pawn_two) { described_class.new(player_two) }

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
      it 'returns array of possible moves but excludes a move 2 squares forward' do
        expect(pawn_two.possible_moves(board.start_coordinates, player_two)).to contain_exactly([3, 4], [4, 4], [5, 4])
      end
    end

  end

  describe '#check_first_move ' do

    subject(:pawn_first) { described_class.new(player_two) }
    let(:player_one) { instance_double(Player) }
    let(:player_two) { instance_double(Player) }

    context 'when Pawn has made zero moves' do

      it 'first_move returns true' do
        expect(pawn_first.first_move()).to eq(true)
      end
    end
  end

end
