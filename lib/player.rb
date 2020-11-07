require 'tty-prompt'

# Asks names of the players controls whos makes the next move

class Player
  attr_accessor :player

  def initialize
    @player = { name: '', next_turn: false }
  end

  def ask_name
    prompt = TTY::Prompt.new
    @player[:name] = prompt.ask('What is your name?')
  end

end
