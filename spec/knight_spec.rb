require 'rspec/autorun'
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'

describe Knight do
  let(:player_one) { Player.new(1) }
  let(:player_two) { Player.new(2) }
  let(:game) { Game.new(player_one, player_two) }
  
  context "When a player selects Knight to move & destination square to move it to" do 

    it "returns false when destination square is already occupied by player's own piece" do
      player_one.data[:next_turn] = true
      game.board[2][2] = game.board[1][2] 
      game.board[1][2] = ''
      start_coordinates = [2, 8]
      finish_coordinates = [3, 6]
      start_square = game.board[0][1]

      expect(start_square.valid_move?(start_coordinates, finish_coordinates, game.board, game.whos_turn)).to eq(false)
    end

    it "returns true when destiantion square is empty" do
      player_one.data[:next_turn] = true
      start_coordinates = [2, 8]
      finish_coordinates = [3, 6]
      start_square = game.board[0][1]

      expect(start_square.valid_move?(start_coordinates, finish_coordinates, game.board, game.whos_turn)).to eq(true)
    end

    it "returns true when destination square contains opponents piece" do
      player_one.data[:next_turn] = true
      game.board[2][2] = game.board[7][1]
      game.board[7][1] = ''
      start_coordinates = [2, 8]
      finish_coordinates = [3, 6]
      start_square = game.board[0][1]

      expect(start_square.valid_move?(start_coordinates, finish_coordinates, game.board, game.whos_turn)).to eq(true)
    end

    it "returns false if destination sqaure is not a valid move" do
      player_one.data[:next_turn] = true
      start_coordinates = [2, 8]
      finish_coordinates = [2, 6]
      start_square = game.board[0][1]

      expect(start_square.valid_move?(start_coordinates, finish_coordinates, game.board, game.whos_turn)).to eq(false)
    end

    it "returns an array of possible moves" do 
      # player_two.data[:next_turn] = true
      start_square = game.board[7][1]
      expect(start_square.possible_moves([2,1])).to eq([[1, 3], [1, -1], [3, 3], [3, -1], [0, 2], [0, 0], [4, 2], [4, 0]]) 
    end

  end
end