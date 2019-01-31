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

  def place_ship ship
    coordinates = place_ship_message(ship)
    valid_coordinates = coordinates.map { |coordinate| @board.valid_coordinate?(coordinate) }
    if !valid_coordinates.all? {|coordinate| coordinate}
      error_message(2); place_ship(ship)
    end
    valid_placement = @board.valid_placement?(ship, coordinates)
    valid_placement ? @board.place(ship, coordinates) : (error_message(3); place_ship(ship))
  end
end