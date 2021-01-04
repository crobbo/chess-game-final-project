
require 'tty-table'


array = [
      [0], [1], [2],
      [0], [1], [2],
      [0], [1], [2],
    ]

# test = array[0][0]

table = TTY::Table.new do |t|
  t << ["a1", "a2"]
  t << ["b1", "b2"]
  end

puts table.render(:ascii) # => # +-------+-------+ # |header1|header2| # +-------+-------+ # |a1 |a2 | # +-------+-------+ # |b1 |b2 | # +-------+-------+