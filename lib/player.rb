require "tty-prompt"

class Player
  attr_accessor :player

  def initialize
    @player = {name: '', next_turn: false}
  end

  def get_name
    prompt = TTY::Prompt.new
    @player[:name] = prompt.ask("What is your name?")
  end

end
