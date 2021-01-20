# def user_input
#   num = loop do
#     num = Integer(gets) rescue nil
#     break num if num && num < 9 && num > 0

#     puts "you didn't enter a valid number..."
#   end
#   return num
# end

def user_input
  num = Integer(gets)
  if num.positive? && num < 9
    num
  else
    puts "Incorrect input, try again"
    user_input
  end
end


user_input