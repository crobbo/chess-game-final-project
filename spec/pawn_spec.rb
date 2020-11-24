# require 'rspec/autorun'
# require_relative '../lib/game.rb'
# require_relative '../lib/player.rb'

# describe Pawn do

#   let(:player_one) { Player.new(1) }
#   let(:player_two) { Player.new(2) }
#   let(:game) { Game.new(player_one, player_two) }

#   context "When a player selects a Pawn to move & destination square to move it to" do

#     xit "returns false when destination square is already occupied by player's own piece" do
#       player_one.data[:next_turn] = true
#       game.board[4][3] = game.board[7][0]
#       game.board[5][3] = game.board[6][0]
#       game.board[7][0] = ''
#       game.board[6][0] = ''
#       start_coordinates = [4, 3]
#       finish_coordinates = [4, 4]
#       start_square = game.board[5][3]
#       expect(start_square.valid_move?(start_coordinates, finish_coordinates, game.board, game.whos_turn)).to eq(false)

#     end

#     xit "returns true when destiantion square is empty" do
#     end

#     xit "returns true when destination square contains opponents piece" do
#     end

#     xit "returns false if destination sqaure is not a valid move" do
#     end

#     it "returns the possible moves for player 1" do
      
#       start_square = game.board[6][4]
#       p game.board[6][4]
      
#       expect(start_square.possible_moves([2, 3], game.whos_turn)).to eq([[2, 4], [1, 4], [3, 4]])
#     end

#   end
# end
