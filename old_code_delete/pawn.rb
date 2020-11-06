class Pawn
  attr_reader :moves

  def initialize
    @moves =
    [[-1, 1],
     [-1, -1],
     [1, 1],
     [1, -1],
     [-1, 1],
     [-1, -1],
     [1, 1],
     [1, -1]
    ]
    @player_one = [ 
        @pawn_one = {valid: true, coordinates: [1, 7]},
        @pawn_two = {valid: true, coordinates: [2, 7]},
        @pawn_three = {valid: true, coordinates: [3, 7]},
        @pawn_four = {valid: true, coordinates: [4, 7]},
        @pawn_five = {valid: true, coordinates: [5, 7]},
        @pawn_six = {valid: true, coordinates: [6, 7]},
        @pawn_seven = {valid: true, coordinates: [7, 7]},
        @pawn_eight = {valid: true, coordinates: [8, 7]}
    ]
    
    @player_one = [ 
        @pawn_one = {valid: true, coordinates: [1, 7]},
        @pawn_two = {valid: true, coordinates: [2, 7]},
        @pawn_three = {valid: true, coordinates: [3, 7]},
        @pawn_four = {valid: true, coordinates: [4, 7]},
        @pawn_five = {valid: true, coordinates: [5, 7]},
        @pawn_six = {valid: true, coordinates: [6, 7]},
        @pawn_seven = {valid: true, coordinates: [7, 7]},
        @pawn_eight = {valid: true, coordinates: [8, 7]}
    ]

  end
end