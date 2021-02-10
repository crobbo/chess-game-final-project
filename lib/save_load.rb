require 'yaml'

class Save_load 

  def initialize
    @file_name = create_unique_file_name
  end

  def save(save_game_variables)
    save_object = {
      board: save_game_variables[0],
      player_one: save_game_variables[1],
      player_two: save_game_variables[2],
      player_one_in_check: save_game_variables[3],
      player_two_in_check: save_game_variables[4]
    }
    File.open("save_files/#{@file_name}.yaml", "w") { |file| file.write(YAML.dump(save_object)) }
    puts "GAME SAVED SUCCESSFULLY."
    exit
  end

  def load(choice)
    file_to_load = Dir.chdir("save_files") { Dir.glob("*.yaml").sort[choice] }
    loaded_game = YAML.load(File.read("save_files/#{file_to_load}"), [Symbol])
    board = loaded_game[:board],
    player_one = loaded_game[:player_one],
    player_two = loaded_game[:player_two],
    player_one_in_check = loaded_game[:player_once_in_check],
    player_two_in_check = loaded_game[:player_two_in_check]
    return variables = [board, player_one, player_two, player_one_in_check, player_two_in_check]
  end

  def ask_for_load
    puts "Do you want to load a previous game? Y/N"
    answer = gets.chomp
    if answer == 'y' || answer == 'Y'
      load_screen
      load(gets.chomp.to_i)
      # puts "Game Loaded"
    else
      nil
    end
  end

  def create_unique_file_name
    Dir.mkdir("save_files")
    count = Dir.glob("save_files/*.yaml").length
    date_and_time = Time.new
    "#{count} - Chess: #{date_and_time.strftime("%d-%m-%Y %I:%M %p")}"
  rescue Errno::EEXIST
    count = Dir.glob("save_files/*.yaml").length
    date_and_time = Time.new
    "#{count} - Chess: #{date_and_time.strftime("%d-%m-%Y %I:%M %p")}"
  end

  def load_screen
    system "clear"
    puts "Press the number of the file you want to load"
    Dir.chdir("save_files") { puts Dir.glob("*.yaml").sort }
  end
end
