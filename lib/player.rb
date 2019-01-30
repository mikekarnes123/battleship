require_relative 'ship'
require_relative 'board'


class Player
  attr_reader :ships, :board

  def initialize
    @board = Board.new
    @ships = []
  end

  def place_ship ship, coordinates
    valid_coordinate = @board.valid_coordinate?(coordinates)
    valid_placement = @board.valid_placement(ship, coordinates)
    !valid_coordinate || !valid_placement
  end
end