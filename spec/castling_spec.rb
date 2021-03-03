require 'rspec/autorun'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/pawn'
require_relative '../lib/board'
require 'pry'

# let(:board) { [[rook_1a, '', '', king_1, '', '', '', ''],
#   ['', '', pawn_1a, pawn_1b, '', '', '', rook_1b],
#   ['', '', '', '', '', '', '', ''],
#   ['', '', '', '', '', '', '', ''],
#   ['', '', pawn_2a, pawn_2b, '', '', '', ''],
#   ['', '', '', '', '', '', '', rook_2a],
#   [rook_1a, '', '', '', '', '', '', ''],
#   ['', '', '', '', '', king_2, '', '']] }

describe Castling do

  let(:player_one) { instance_double(Player, data: {name: 'Amy', number: 1}) }
  let(:player_two) { instance_double(Player, data: {name: 'Christian', number: 2}) }

  let(:pawn_1a) { instance_double(Pawn, which_player: player_one, type: 'Pawn') }
  let(:pawn_1b) { instance_double(Pawn, which_player: player_one, type: 'Pawn') }
  let(:rook_1a) { instance_double(Rook, which_player: player_one, type: 'Rook') }
  let(:rook_1b) { instance_double(Rook, which_player: player_one, type: 'Rook') }
  let(:king_1) { instance_double(King, which_player: player_one, type: 'King') }
  
  let(:pawn_2a) { instance_double(Pawn, which_player: player_two, type: 'Pawn') }
  let(:pawn_2b) { instance_double(Pawn, which_player: player_two, type: 'Pawn') }
  let(:rook_2a) { instance_double(Rook, which_player: player_two, type: 'Rook') }
  let(:rook_2b) { instance_double(Rook, which_player: player_two, type: 'Rook') }
  let(:king_2) { instance_double(King, which_player: player_two, type: 'King') }
  


end