require_relative 'ship'
require_relative 'board'
require_relative 'dialogue'

class Player
  include Dialogue
  attr_reader :ships, :board, :player_guesses

  def initialize
    @board = Board.new
    @ships = [Ship.new("Cruiser", 2), Ship.new("Submarine", 3)]
    @player_guesses = []
  end

  def initialize_ship_placement
    @ships.each do |ship|
      place_player_ship ship
      render_board "Player", @board.render(true)
    end
  end

  def place_player_ship ship
    coordinates = place_ship_message ship
    valid_coordinates = coordinates.map do |coordinate| 
      @board.valid_coordinate? coordinate
    end
    case
    when !valid_coordinates.all?
      error_message 2; place_player_ship ship
    when !@board.valid_placement?(ship, coordinates)
      error_message 3; place_player_ship ship
    else
      @board.place ship, coordinates
    end
  end

  def guess
    guess_coord = player_guess_input
    valid_coordinate = @board.valid_coordinate? guess_coord
    if @player_guesses.include? guess_coord
      error_message 4
      guess
    elsif !valid_coordinate
      error_message 2
      guess
    else
      @player_guesses << guess_coord
      guess_coord
    end
  end

  def recieve_shot computer_guess
    @board.cells[computer_guess].fire_upon
    cell_render = @board.cells[computer_guess].render
    ship_name = @board.cells[computer_guess].ship.name if cell_render == "X"
    ["The Computer", cell_render, ship_name, computer_guess]
  end
end
