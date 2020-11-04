require 'tty-table'

class Board
    attr_accessor :table
  def initialize
    @table = TTY::Table.new do |t|
        t << ["\u265C", "\u265E", "\u265D", "\u265B", "\u265A", "\u265D", "\u265E", "\u265C"]
        t << ["\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"]
        t << ["", "", "", "", "", "", "", ""]
        t << ["", "", "", "", "", "", "", ""]
        t << ["", "", "", "", "", "", "", ""]
        t << ["", "", "", "", "", "", "", ""]
        t << ["\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659"]
        t << ["\u2656", "\u2658", "\u2657", "\u2655", "\u2654", "\u2657", "\u2658", "\u2656"]
      end
  end
end
new_game = Board.new
puts new_game.table.render(:unicode)