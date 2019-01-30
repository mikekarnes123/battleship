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
    puts "Place #{ship.name} (#{ship.length}cells)"
    coordinates = []
    ship.length.times do |x|
      puts "{x} coordinate?"
      coordinate_response = gets.chomp
      coordinates << coordinate_response
    end
    coordinates
  end

  def error_message code
  end


end