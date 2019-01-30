require_relative 'dialogue'
require_relative 'player'
require_relative 'computer'
require_relative 'ship'



class Game
  include Dialogue

  attr_accessor :ready, :player, :computer

  def intialize
    @ready = false
    @player = nil
    @computer = nil
  end

  def menu
    initial_greeting ? @ready = true : end_game_message
  end

  def start_game
    @computer = Computer.new
    @player = Player.new
    initialize_ship_message
    place_ship_stage
  end
  
  def place_ship_stage
    cruiser = Ship.new("Cruiser", 2)
    submarine = Ship.new("Submarine", 3)
    [cruiser, submarine].map {|ship|
      player_coordinates = place_ship_message(ship)
      @player.place_ship( player_coordinates)
    }
    
  end
end