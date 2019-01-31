require_relative 'ship'
require_relative 'board'
require_relative 'dialogue'
require "pry"

class Player
  include Dialogue
  attr_reader :ships, :board, :player_guesses

  def initialize
    @board = Board.new
    @ships = [Ship.new("Cruiser", 2), Ship.new("Submarine", 3)]
    @player_guesses = []
  end

  def initialize_ship_placement
    @ships.each { |ship|
      place_player_ship(ship)
      render_board("Player", @board.render(true))
    }
  end

  def place_player_ship ship
    coordinates = place_ship_message(ship)
    valid_coordinates = coordinates.map { |coordinate| @board.valid_coordinate?(coordinate) }
    case
    when !valid_coordinates.all?
      error_message(2); place_player_ship(ship)
    when !@board.valid_placement?(ship, coordinates)
      error_message(3); place_player_ship(ship)
    else
      @board.place(ship, coordinates)
    end
  end

  def guess
    guess_coord = player_guess_input
    if @player_guesses.include? guess_coord
      error_message 4
      guess
    else
      @player_guesses << guess_coord
      guess_coord
    end
  end

  def recieve_shot(computer_guess)
    @board.cells[computer_guess].fire_upon
    case @board.cells[computer_guess].render
    when "M"
      puts "The Computer Missed A Shot On #{computer_guess}!"
      puts "\n"
    when "H"
      puts "The Computer Landed A Hit On #{computer_guess}!"
      puts "\n"
    else
      puts "The Computer Sunk Your #{@board.cells[computer_guess].ship.name}"
      puts "\n"
    end
  end
end
