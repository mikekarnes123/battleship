require_relative 'board'
require 'pry'
class Computer

  attr_reader :board

  def initialize
    @board = Board.new
    @ships = [Ship.new("Cruiser", 2), Ship.new("Submarine", 3)]
    @ships_coordinates = {}
  end

  def place_ship
    @ships.each {|ship|
      place_random(ship)
    }
  end
  
  def place_random ship
      row_or_column = [@board.valid_rows, @board.valid_rows.transpose][rand(0..1)][rand(0..3)]
      x = ship.length - 1
      if !@ships_coordinates[ship.name]
        @ships_coordinates[ship.name] = []
      end
      first_coordinate = row_or_column[rand(0..3)]
      first_index = row_or_column.index(first_coordinate)
      @ships_coordinates[ship.name] << first_coordinate

      x.times do
        @ships_coordinates[ship.name] << row_or_column[first_index += 1]
        # place_random if @ships_coordinates[ship.name].include?()
      end
      valid_placement = @board.valid_placement?(ship, @ships_coordinates[ship.name])
      if valid_placement
        @board.place(ship, @ships_coordinates[ship.name]) 
      else
        @ships_coordinates = {}
        place_ship
      end
  end
end