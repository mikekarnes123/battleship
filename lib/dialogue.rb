module Dialogue
  def initial_greeting(boolean = false)
    puts "Welcome to BATTLESHIP"
    puts "\n"
    puts "[p] to play. [q] to quit."
    puts "\n"
    player_response =  gets.chomp
    boolean = true if player_response == "p"
  end

  def request_size_message
    puts "Enter size for Board"
    gets.chomp.to_i
  end

  def end_game_message
    puts "\n"
    puts "Good Bye"
  end

  def initialize_ship_message
    puts "I have laid out my ships on the grid."
    puts "\n"
    puts "You now need to lay out your two ships"
    puts "\n"
  end

  def place_ship_message(ship)
    next_coordinates = ship.length - 1
    puts "Place #{ship.name} (#{ship.length}cells)"
    puts "\n"
    coordinates = []
    puts "First Coordinate?"
    first_coord = gets.chomp
    coordinates << first_coord.capitalize
    next_coordinates.times do |x|
      puts "\n"
      puts "Next Coord?"
      coordinate_response = gets.chomp
      coordinates << coordinate_response.capitalize
    end
    coordinates
  end

  def render_board(user, board)
    puts "\n"
    puts "#{"=" * 5} #{user} Board #{"=" * 5}"
    puts "\n"
    puts board
    puts "\n"
    puts "#{"=" * 25}"
  end

  def ready_message
    puts "#{"="*10}Prepare For Battle!!#{"="*10}"
    puts "\n"
  end

  def error_message(code)
    case code
    when 2
      puts "#{"*" * 10}Invalid Coordinates!!!#{"*" * 10}"
      puts "\n"
    when 3
      puts "#{"*" * 10}Invalid Placement!!!#{"*" * 10}"
      puts "\n"
    when 4
      puts "#{"*" * 10}You've Already Fired At That Coordinate!#{"*" * 10}"
      puts "\n"
    end
  end

  def player_guess_input
    puts "Which Coordinate Would You Like To Fire On?"
    gets.chomp.capitalize
  end

  def shot_response_feedback(user, cell_render, ship_name, coordinate)
    case cell_render
    when "M"
      puts "#{user} Missed A Shot On #{coordinate}!"
      puts "\n"
    when "H"
      puts "#{user} Landed A Hit On #{coordinate}!"
      puts "\n"
    else
      puts "#{user} Sunk A #{ship_name}"
      puts "\n"
    end
  end

  def end_game_message(player_win, computer_win)
    puts player_win ? "You Win!!! :)" : "The Computer Has Won :("
  end

  def cancel_game_message
    puts "\n"
    puts "#{"*" * 10} Goodbye #{"*" * 10}"
    puts "\n"
  end
end
