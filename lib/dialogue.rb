module Dialogue
  def initial_greeting boolean = false
    puts "Welcome to BATTLESHIP"
    puts "[p] to play. [q] to quit."
    player_response =  gets.chomp
    boolean = true if player_response == "p" 
  end

  def end_game_message
    puts "Good Bye"
  end

  def initialize_ship_message 
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships"
  end

  def place_ship_message ship
    next_coordinates = ship.length - 1
    puts "Place #{ship.name} (#{ship.length}cells)"
    coordinates = []
    puts "First Coordinate?"
    first_coord = gets.chomp
    coordinates << first_coord.capitalize
    next_coordinates.times do |x|
      puts "Next Coord?"
      coordinate_response = gets.chomp
      coordinates << coordinate_response.capitalize
    end
    coordinates
  end

  def render_board user, board
    puts "#{"=" * 5}#{user}#{"=" * 5}"
    puts board
  end

  def fire_missles_message
    puts "Enter A Coordinate for your shot"
    gets.chomp.capitalize
  end

  def error_message code
    case code 
    when 2
      puts "#{"-" * 10}Invalid Coordinates!!!#{"-" * 10}"
      puts "#{"-" * 40}"
    when 3
      puts "#{"-" * 10}Invalid Placement!!!#{"-" * 10}"
      puts "#{"-" * 40}"
    end
  end


end