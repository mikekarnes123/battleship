require_relative 'board'
require 'pry'
class Computer
  attr_reader :board,
              :available_cells,
              :ships

  def initialize
    @board = Board.new
    @ships = [Ship.new("Cruiser", 2), Ship.new("Submarine", 3)]
    @ships_coordinates = {"Cruiser" => [], "Submarine" => []}
    @available_cells = @board.cells.keys
  end

  def initialize_ship_placement
    @ships.each { |ship| generate_random_coordinates(ship) }
  end

  def generate_random_coordinates ship
    valid_board = [@board.valid_rows, @board.valid_columns]
    row_or_column = valid_board[rand(0..1)][rand(0..3)]
    first_coordinate = row_or_column[rand(0..3)]
    first_index = row_or_column.index(first_coordinate)
    @ships_coordinates[ship.name] << first_coordinate
    remaining_cells = ship.length - 1
    remaining_cells.times do 
      @ships_coordinates[ship.name] << row_or_column[first_index += 1]
    end
    validate_random_coordinates ship, ship.name
  end

  def validate_random_coordinates ship, ship_name
    valid_placement = @board.valid_placement?(ship, @ships_coordinates[ship_name])
    if valid_placement 
      @board.place(ship, @ships_coordinates[ship_name]) 
    else
      @ships_coordinates[ship_name] = []
      generate_random_coordinates(ship)
    end
  end

  def guess
    random_coord = @available_cells.sample
    @available_cells.delete(random_coord)
  end

  def recieve_shot(player_guess)
    @board.cells[player_guess].fire_upon
    cell_render = @board.cells[player_guess].render
    ship_name = @board.cells[player_guess].ship.name if cell_render == "X"
    ["You", cell_render, ship_name, player_guess]
  end
end
