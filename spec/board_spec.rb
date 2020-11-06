require 'tty-table'

describe Board do
  it "Checks the board is created" do
    board = Board.new
    
    expect(board.build).to eq(@table = TTY::Table.new do |t|
      t << ["8", "\u265C", "\u265E", "\u265D", "\u265B", "\u265A", "\u265D", "\u265E", "\u265C"]
      t << ["7", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F", "\u265F"]
      t << ["6", "", "", "", "", "", "", "", ""]
      t << ["5", "", "", "", "", "", "", "", ""]
      t << ["4", "", "", "", "", "", "", "", ""]
      t << ["3", "", "", "", "", "", "", "", ""]
      t << ["2", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659", "\u2659"]
      t << ["1", "\u2656", "\u2658", "\u2657", "\u2655", "\u2654", "\u2657", "\u2658", "\u2656"]
      t << ["", "1", "2", "3", "4", "5", "6", "7", "8"])
