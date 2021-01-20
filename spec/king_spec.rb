require 'rspec/autorun'
require_relative '../lib/king'
require_relative '../lib/player'
require_relative '../lib/board'



describe King do

  let(:player_one) { instance_double(Player)}
  let(:player_two) { instance_double(Player)}

  describe '#possible_moves' do

    subject(:king_moves) { described_class.new(player_one) }
  

    context 'When #possible_moves is called' do

      let(:start_coordinates) { [4, 4] }

      it 'returns an Array of possible moves' do
        expect(king_moves.possible_moves(start_coordinates)).to contain_exactly([4, 3], [5, 3], [5, 4], [5, 5], [4, 5], [3, 5], [3, 4], [3, 3])
      end

    end

    context 'When #possible_moves is called and start coordinates are at the edge of the board' do
      
      let(:start_coordinates) { [1, 1] }

      it 'returns array of possible moves' do
        # expect(king_moves.possible_moves(start_coordinates)).to include([2, 1], [2, 2], [1, 2])
        expect(king_moves.possible_moves())
      end
    end

  end

  describe '#valid_moves' do
    subject(:king_valid) { described_class.new(player_one) }

    let(:chess_board) { instance_double(Board, board: [
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', '']
    ], start_coordinates: [5, 7], finish_coordinates: [5, 6]) } 
    
    context 'when player is moving to an empty square' do
      
 

      before do
        chess_board.board[2][4] = ''
      end
    
      it 'returns true' do
        expect(king_valid.valid_move?(chess_board, player_one)).to eq(true)
      end
    end

    context "when player is moving to a square with an opponent's piece" do

      let(:opponents_pawn) { instance_double(Pawn, which_player: player_two)}

      before do
        chess_board.board[2][4] = opponents_pawn
      end

      it 'returns true' do
        expect(king_valid.valid_move?(chess_board, player_one)).to eq(true)
      end
    end

    context "when player is moving to a square with the player's own piece" do

      let(:players_pawn) { instance_double(Pawn, which_player: player_one)}

      before do
        chess_board.board[2][4] = players_pawn
      end

      it 'returns false' do
        expect(king_valid.valid_move?(chess_board, player_one)).to eq(false)
      end
    end

  end
end
