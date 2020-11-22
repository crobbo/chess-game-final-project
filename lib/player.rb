require 'tty-prompt'

# Asks names of the players controls whos makes the next move

class Player

  attr_accessor :data, :graveyard

  def initialize(num)
    @data = { name: '', next_turn: false, number: num } ##change to data
    @graveyard = []
  end

  def ask_name
    prompt = TTY::Prompt.new
    @data[:name] = prompt.ask('What is your name?')
  end

  def add_to_graveyard(chess, board)
    if board[8 - chess.start_coordinates[1]][chess.start_coordinates[0] - 1] == ''
      nil
    else
      @graveyard << board[8 - chess.start_coordinates[1]][chess.start_coordinates[0] - 1]
    end
  end
  
end
