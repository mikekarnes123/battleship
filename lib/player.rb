require_relative 'ship'
require_relative 'board'
require_relative 'dialogue'
require "pry"

class Player
  include Dialogue
  attr_reader :ships, :board

  def initialize
    @board = Board.new
    @ships = [Ship.new("Cruiser", 2), Ship.new("Submarine", 3)]
  end
  
  def get_coordinates
    @ships.each { |ship|
      place_ship(ship)
      render_board("Player", @board.render(true))
    }
  end

  def place_ship(ship)
    coordinates = place_ship_message(ship)
    valid_coordinates = coordinates.map { |coordinate| @board.valid_coordinate?(coordinate) }
    case 
    when !valid_coordinates.all?
      error_message(2); place_ship(ship)
    when !@board.valid_placement?(ship, coordinates)
      error_message(3); place_ship(ship)
    else
      @board.place(ship, coordinates)
    end
  end

  def fired_on coordinate
    @board.cells[coordinate].fire_upon
  end
end