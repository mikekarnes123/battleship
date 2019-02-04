require 'minitest/autorun'
require 'minitest/pride'
require './lib/computer'
require './lib/ship'
require './lib/board'

class ComputerTest < MiniTest::Test
  def setup
    @computer = Computer.new(10)
  end

  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_it_initially_has_a_board
    assert_instance_of Board, @computer.board
  end

  def test_it_chooses_random_coordinates
    @computer.initialize_ship_placement
  end

  def test_computer_can_make_coordinate_guess
    coords_before_guess = @computer.board.cells.keys
    coords_after_guess = @computer.available_cells
    guess = @computer.guess
    assert coords_before_guess.include?(guess)
    refute coords_after_guess.include?(guess)
  end

  def test_computer_can_recieve_shot
    @computer.recieve_shot("A1")
    assert @computer.board.cells["A1"].fired_upon?
    assert_equal "M", @computer.board.cells["A1"].render
    @computer.board.place@computer.ships[0], ["C2", "C3"]
    @computer.recieve_shot("C3")
    assert_equal "H", @computer.board.cells["C3"].render
  end
end
