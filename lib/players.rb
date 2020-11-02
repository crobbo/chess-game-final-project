require 'pry'

class Players
  attr_accessor :player1, :player2

  def initialize
    @player1 = {name: '', next_turn: false}
    @player2 = {name: '', next_turn: false}
  end

  def get_names
    puts "Player 1 please enter your name:"
    @player1[:name] = gets.chomp
    puts "Player 2 please enter your name:"
    @player2[:name] = gets.chomp
  end

  def who_goes_first
    heads_tails = { one: 'Heads', two: 'Tails'}
    puts "Let's flip a coin. Winner chooses who goes first!"
    puts '1.....2.....3......FLIP!'
    puts 'Player 1: For Tails choose enter 2, for Heads enter 1'
    num = loop do
        puts 'enter a number'
        num = Integer(gets) rescue nil
        break num if num
      
        puts "you didn't enter a number..."
      end
  
      return heads_tails[num]
  end
end

new_game = Players.new
new_game.who_goes_first
