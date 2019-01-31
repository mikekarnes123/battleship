require_relative 'board'
require 'pry'
class Computer

  attr_reader :board

  def initialize
    @board = Board.new
    @ships = [Ship.new("Cruiser", 2), Ship.new("Submarine", 3)]
    @ships_coordinates = {"Cruiser" => [], "Submarine" => []}
  end

  def place_ships
    @ships.each { |ship| generate_random_coordinates(ship) }
  end
  
  def generate_random_coordinates ship
    row_or_column = [@board.valid_rows, @board.valid_rows.transpose][rand(0..1)][rand(0..3)]
    first_coordinate = row_or_column[rand(0..3)]
    first_index = row_or_column.index(first_coordinate)
    @ships_coordinates[ship.name] << first_coordinate
    remaining_cells = ship.length - 1
    remaining_cells.times {|_| @ships_coordinates[ship.name] << row_or_column[first_index += 1] }
    valid_placement = @board.valid_placement?(ship, @ships_coordinates[ship.name])
    valid_placement ? @board.place(ship, @ships_coordinates[ship.name]) : 
    (@ships_coordinates[ship.name] = []; generate_random_coordinates(ship))
  end
end