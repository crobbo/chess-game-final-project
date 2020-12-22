require 'rspec/autorun'
require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/pawn'


describe Bishop do

  let(:player_one) { instance_double(Player)}
  let(:player_two) { instance_double(Player)}

  describe '#valid_move?' do
    subject(:bishop) { described_class.new(player_one) }

    
    context 'when moving to an empty square' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [7, 5], finish_coordinates: [3, 1], start_square: bishop, finish_square: '') }
      
      before do
        chess.board[3][6] = bishop
      end
    
      it 'returns true' do
        expect(bishop.valid_move?(chess, player_one)).to eq(true)
      end
    end

    context 'when moving to a square occupied by opponents piece' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [7, 5], finish_coordinates: [3, 1], start_square: bishop, finish_square: knight) }
      
      let(:knight) { instance_double(Knight, which_player: player_two) }

      before do
        chess.board[3][6] = bishop
      end

      it 'returns true' do
        expect(bishop.valid_move?(chess, player_one)).to eq(true)
      end
    end

    context 'when moving to a square occupied by players own piece' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [7, 5], finish_coordinates: [3, 1], start_square: bishop, finish_square: knight) }
      
      let(:knight) { instance_double(Knight, which_player: player_one) }

      before do
        chess.board[3][6] = bishop
      end

      it 'returns false' do
        expect(bishop.valid_move?(chess, player_one)).to eq(false)
      end
    end
  end

  describe '#possible_moves' do
  end

  describe '#find_diagonals' do
    subject(:bishop_diags) { described_class.new(player_one) }
    let(:chess) { instance_double(Board, start_coordinates: [2, 3]) }

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
    subject(:bishops_antediags) { described_class.new(player_one) }
    let(:chess) { instance_double(Board, start_coordinates: [6, 6]) }

    before do
      allow(bishops_antediags).to receive(:diag_top_left).and_return([[1, 7]])
      allow(bishops_antediags).to receive(:diag_bottom_right).and_return([[3, 5], [4, 4], [5, 3], [6, 2], [7, 1]]) 
    end

    context 'when #find_antedigonals is called' do
      it 'returns an array of all possible diagonal moves' do
        expect(bishops_antediags.find_antediagonals(chess)).to eq([[[1, 7]], [[3, 5], [4, 4], [5, 3], [6, 2], [7, 1]]])
      end
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

  describe '#space_between_diagonals?' do

    subject(:diagonals) { described_class.new(player_one) }

    context 'when there is clear space between start and finish' do

    let(:chess) { instance_double(Board, board: [
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '']
    ], start_coordinates: [1, 1], finish_coordinates: [8, 8]) }

      it 'returns true' do
        expect(diagonals.space_between_diagonals?(chess, [[[]],[[2, 2],[3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [8, 8]]])).to eq(true)
      end
    end

    context "when a piece is between start and finish" do
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [1, 1], finish_coordinates: [8, 8]) }

      let(:players_piece) { instance_double(Pawn) }

      before do
        chess.board[4][3] = players_piece
      end

      it 'returns false' do
        expect(diagonals.space_between_diagonals?(chess, [[[]],[[2, 2],[3, 3], [4, 4], [5, 5], [6, 6], [7, 7], [8, 8]]])).to eq(false)
      end
    end

    context 'when x-coordinate of start is greater than finish' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [8, 8], finish_coordinates: [1, 1]) }

      let(:players_piece) { instance_double(Pawn) }

      it 'returns true when space between' do
        expect(diagonals.space_between_diagonals?(chess, [[[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1]], [[]]] )).to eq(true)
      end

      it 'returns false when piece in the way' do
        chess.board[4][3] = players_piece
        expect(diagonals.space_between_diagonals?(chess, [[[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1]], [[]]])).to eq(false)
      end
    end
  

    context 'when x-coordinate of start is greater than finish' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [6, 6], finish_coordinates: [2, 2]) }

      let(:players_piece) { instance_double(Pawn) }

      it 'returns true when space between' do
        expect(diagonals.space_between_diagonals?(chess, [[[5, 5], [4, 4], [3, 3], [2, 2], [1, 1]], [[7, 7], [8, 8]]])).to eq(true)
      end

      it 'returns false when piece in the way' do
        chess.board[4][3] = players_piece
        expect(diagonals.space_between_diagonals?(chess, [[[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1]], [[]]])).to eq(false)
      end
    end
  end

  describe '#space_between_antediagonals?' do

    subject(:antediagonals) { described_class.new(player_one) }

    context 'when there is clear space between start and finish' do

    let(:chess) { instance_double(Board, board: [
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '']
    ], start_coordinates: [2, 6], finish_coordinates: [6, 2]) }

      it 'returns true' do
        expect(antediagonals.space_between_antediagonals?(chess, [[[1, 7]], [[3, 5], [4, 4], [5, 3], [6, 2], [7, 1]]])).to eq(true)
      end
    end

    context "when a piece is between start and finish" do
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [2, 6], finish_coordinates: [6, 2]) }

      let(:players_piece) { instance_double(Pawn) }

      before do
        chess.board[4][3] = players_piece
      end

      it 'returns false' do
        expect(antediagonals.space_between_antediagonals?(chess, [[[1, 7]], [[3, 5], [4, 4], [5, 3], [6, 2], [7, 1]]])).to eq(false)
      end
    end

    context 'when x-coordinate of start is greater than finish' do

      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [6, 2], finish_coordinates: [2, 6]) }

      let(:players_piece) { instance_double(Pawn) }

      it 'returns true when space between' do
        expect(antediagonals.space_between_antediagonals?(chess, [[[3, 5], [4, 4], [5, 3], [6, 2]], [7, 1], [[1, 7]]] )).to eq(true)
      end

      it 'returns false when piece in the way' do
        chess.board[4][3] = players_piece
        expect(antediagonals.space_between_antediagonals?(chess, [[[3, 5], [4, 4], [5, 3], [6, 2]], [7, 1], [[1, 7]]] )).to eq(false)
      end
    end
  end
end
