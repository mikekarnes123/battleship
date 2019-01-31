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
    @ships.each {|ship|
     coordinates = place_ship_message(ship)
    place_ship(ship, coordinates)
    }

  end

  def place_ship ship, coordinates
    valid_coordinates = coordinates.map {|coordinate|
      @board.valid_coordinate?(coordinate)
    }

    valid_placement = @board.valid_placement?(ship, coordinates)
    if valid_coordinates.all? && valid_placement
      coordinates.each {|coordinate|
        @board.cells[coordinate].place_ship(ship)
      }
    end
    true
  end
end