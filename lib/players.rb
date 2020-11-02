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

  def coin_flip
    heads_tails = { 1 => 'Heads', 2 => 'Tails'}
    puts "Let's flip a coin....Heads wins, Tails loses!"
    puts '1.....2.....3......FLIP!'
    puts 'Player 1 take a guess! For Tails enter 2, for Heads enter 1'
    num = loop do
        puts 'enter a number'
        num = Integer(gets) rescue nil
        break num if num

        puts "you didn't enter a 1 or a 2..."
      end
  
      return heads_tails[num]
  end

  def who_goes_first
    arr = ['Heads', 'Tails']
    if coin_flip == arr.sample
      puts "You Win!"
      num = loop do
        puts 'Enter 1 to play first or enter 2 to go second'
        num = Integer(gets) rescue nil
        break num if num

        puts "you didn't enter a 1 or a 2..."
      end
      if num == 1 
        @player1[:next_turn] = true
      else
        @player2[:next_turn] = true
      end
    else
      puts "You Lose!"
      num = loop do
        puts 'Player 2 ==> enter 1 to play first or enter 2 to go second'
        num = Integer(gets) rescue nil
        break num if num

        puts "you didn't enter a 1 or a 2..."
      end
      if num == 1 
        @player2[:next_turn] = true
      else
        @player1[:next_turn] = true
      end
    end
    binding.pry
  end
end

new_game = Players.new
new_game.who_goes_first
