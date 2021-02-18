require 'rspec/autorun'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/pawn'
require_relative '../lib/board'
require 'pry'

describe Board do
  let(:player_one) { instance_double(Player, data: {name: 'Amy', number: 1}) }
  let(:player_two) { instance_double(Player, data: {name: 'Christian', number: 2}) }

  let(:pawn_one) { instance_double(Pawn, which_player: player_one, type: 'Pawn') }
  let(:pawn_two) { instance_double(Pawn, which_player: player_two, type: 'Pawn') }
  let(:rook_one) { instance_double(Rook, which_player: player_two, type: 'Pawn') }

    describe 'find_end_pawn' do

      context 'when player 1 pawn reaches the opposite end of the board' do
          subject(:board_pawn) { described_class.new(player_one, player_two) }

          before do
            board_pawn.instance_variable_set("@board", 
              [['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', pawn_one, '', '', '', '']])
            end

            it 'returns coordinates' do
              expect(board_pawn.find_end_pawn(player_one)).to eq([4, 1])
            end
        end


      context 'when player 2 pawn reaches the opposite end of the board' do
          subject(:board_pawn) { described_class.new(player_one, player_two) }

          before do
            board_pawn.instance_variable_set("@board", 
              [['', '', '', pawn_two, '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', ''],
              ['', '', '', '', '', '', '', '']
            ])
          end

          it 'returns coordinates' do
            expect(board_pawn.find_end_pawn(player_two)).to eq([4, 8])
          end
        end
      end

    describe 'initiate_swap' do
      context 'When player chooses Pawn to swap' do

        subject(:board_swap) { described_class.new(player_one, player_two) }

        before do
          board_swap.instance_variable_set("@board", 
                  [['', '', '', '', '', '', '', ''],
                  ['', '', '', '', '', '', '', ''],
                  ['', '', '', '', '', '', '', ''],
                  ['', '', '', '', '', '', '', ''],
                  ['', '', '', '', '', '', '', ''],
                  ['', '', '', '', '', '', '', ''],
                  ['', '', '', '', '', '', '', ''],
                  ['', '', '', pawn_one, '', '', '', '']
                  ])
          allow(player_two).to receive(:graveyard).and_return([pawn_two])
        end

        let(:board) { board_swap.board }
      
        it 'swaps pawn for rook' do
          board_swap.initiate_swap([4, 1], rook_one)
          expect(board).to eq([['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', '', '', '', '', ''],
            ['', '', '', rook_one, '', '', '', '']
            ])
        end
      end 
    end 

    describe '#create_new_piece' do

      context 'When a Player chooses to reintroduce a Queen' do

        subject(:board_create) { described_class.new(player_one, player_two) }

          it 'creates Queen class' do
            expect(board_create.create_new_piece(["Queen"], player_one).type).to eq('Queen') 
          end
      end
    end
end