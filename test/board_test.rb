require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new

  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_has_cells_hash_4_by_4
    cell_keys = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    cell_keys.each {|key| 
    assert_instance_of Cell, @board.cells[key]
    }
    assert_equal cell_keys ,@board.cells.keys
  end

  def test_it_can_tell_a_valid_coordinate
    assert @board.valid_coordinate?("A1")
    refute @board.valid_coordinate?("R1")
  end

  def test_if_valid_ship_placement
    submarine = Ship.new("Submarine", 3)
    cruiser = Ship.new("Cruiser", 2)

    assert @board.valid_placement?(submarine, ["A2", "B2", "C2"])
    refute @board.valid_placement?(submarine, ["A1", "A2", "A4"])
    assert @board.valid_placement?(submarine, ["A1", "A2", "A3"])
    refute @board.valid_placement?(cruiser, ["A1", "A2", "A3"])

    assert @board.valid_placement?(submarine, ["B1", "B2", "B3"])


  end
end