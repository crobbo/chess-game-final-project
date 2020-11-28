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

  describe '#possible_moves'do
    
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


  describe '#check_forward_move?' do
    context 'when Player 1 pawn is moving one space forward on first go' do
      subject(:pawn_move_one) { described_class.new(player_one) }
      let(:player_rook) { instance_double(Rook, which_player: player_one)}
      let(:opponent_rook) { instance_double(Rook, which_player: player_two)}
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [5, 7], finish_coordinates: [5, 6]) }
      let(:possible_moves) { [[[4, 6], [6, 6]], [[5, 6], [5, 5]]] }

      it 'returns true when square is empty' do
        chess.board[2][4] = ''
        expect(pawn_move_one.check_forward_moves(chess, player_one, possible_moves)).to eq(true)
      end

      it 'returns false when square contains players piece' do
        chess.board[2][4] = player_rook
        expect(pawn_move_one.check_forward_moves(chess, player_one, possible_moves)).to eq(false)
      end

      it 'returns false when square contains opponents piece' do
        chess.board[2][4] = opponent_rook
        expect(pawn_move_one.check_forward_moves(chess, player_one, possible_moves)).to eq(false)
      end

    end

    context 'when player 1 pawn is moving two squares forward on first go' do
      subject(:pawn_move_two) { described_class.new(player_one) }
      let(:player_rook) { instance_double(Rook, which_player: player_one)}
      let(:opponent_rook) { instance_double(Rook, which_player: player_two)}
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [5, 7], finish_coordinates: [5, 5]) }
      let(:possible_moves) { [[[4, 6], [6, 6]], [[5, 6], [5, 5]]] }


      it 'returns true when sqaure is empty' do
        chess.board[3][4] = ''
        expect(pawn_move_two.check_forward_moves(chess, player_one, possible_moves)).to eq(true)
      end

      it 'returns false when square contains players piece' do
        chess.board[3][4] = player_rook
        expect(pawn_move_two.check_forward_moves(chess, player_one, possible_moves)).to eq(false)
      end

      it 'returns false when square contains opponents piece' do
        chess.board[3][4] = player_rook
        expect(pawn_move_two.check_forward_moves(chess, player_one, possible_moves)).to eq(false)
      end
    end

    context 'when Player 1 pawn is making a forward move (1 square) that is not its first move' do
      subject(:pawn_move_two) { described_class.new(player_one) }
      let(:player_rook) { instance_double(Rook, which_player: player_one)}
      let(:opponent_rook) { instance_double(Rook, which_player: player_two)}
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [5, 4], finish_coordinates: [5, 3]) }
      let(:possible_moves) { [[[4, 3], [6, 3]], [[5, 3]]] }

      before do
        pawn_move_two.change_first_move
      end 

      it 'returns true when square is empty' do
        chess.board[5][4] = ''
        expect(pawn_move_two.check_forward_moves(chess, player_one, possible_moves)).to eq(true)
      end

      it 'returns false when square contains players piece' do
        chess.board[5][4] = player_rook
        expect(pawn_move_two.check_forward_moves(chess, player_one, possible_moves)).to eq(false)
      end

      it 'returns false when square contains opponents piece' do
        chess.board[5][4] = opponent_rook
        expect(pawn_move_two.check_forward_moves(chess, player_one, possible_moves)).to eq(false)
      end

    end


    context 'when Player 1 pawn is making a forward move (2 squares) that is not its first move' do
      subject(:pawn_move_two) { described_class.new(player_one) }
      let(:player_rook) { instance_double(Rook, which_player: player_one)}
      let(:opponent_rook) { instance_double(Rook, which_player: player_two)}
      let(:chess) { instance_double(Board, board: [
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', '']
      ], start_coordinates: [5, 4], finish_coordinates: [5, 2]) }
      let(:possible_moves) { [[[4, 3], [6, 3]], [[5, 3]]] }

      before do
        pawn_move_two.change_first_move
      end 

      it 'returns false when square is empty' do
        chess.board[6][4] = ''
        expect(pawn_move_two.check_forward_moves(chess, player_one, possible_moves)).to eq(false)
      end

      it 'returns false when square contains players piece' do
        chess.board[6][4] = player_rook
        expect(pawn_move_two.check_forward_moves(chess, player_one, possible_moves)).to eq(false)
      end

      it 'returns false when square contains opponents piece' do
        chess.board[6][4] = opponent_rook
        expect(pawn_move_two.check_forward_moves(chess, player_one, possible_moves)).to eq(false)
      end

    end



  
  end

  describe '#check_diagonal_move' do
  end

end
