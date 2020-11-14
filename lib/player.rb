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


end
