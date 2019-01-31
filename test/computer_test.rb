require 'minitest/autorun'
require 'minitest/pride'
require './lib/computer'
require './lib/ship'
require './lib/board'

class ComputerTest < MiniTest::Test
  def setup
    @computer = Computer.new
  end
  def test_it_exists
    assert_instance_of Computer, @computer
  end

  def test_it_initially_has_a_board
    assert_instance_of Board, @computer.board
  end

  def test_it_chooses_random_coordinates
    @computer.place_ship
  end
end