require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new(4)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_has_a_board_size_and_cells_according_to_size
    cell_keys = @board.cells.keys
    cell_keys.each do |key|
      assert_instance_of Cell, @board.cells[key]
    end
    assert_equal cell_keys ,@board.cells.keys
    assert_equal 4, @board.size
  end

  def test_it_can_tell_a_valid_coordinate
    assert @board.valid_coordinate? "A1" 
    refute @board.valid_coordinate? "R1"
  end

  def test_if_valid_ship_placement
    submarine = Ship.new "Submarine", 3
    cruiser = Ship.new "Cruiser", 2
    refute @board.valid_placement? submarine, ["A1", "A2", "A4"]
    refute @board.valid_placement? cruiser, ["A1", "A2", "A3"]
    assert @board.valid_placement? cruiser, ["D1", "D2"]
    assert @board.valid_placement? submarine, ["A2", "B2", "C2"]
    assert @board.valid_placement? submarine, ["B3", "B1", "B2"]
    assert @board.valid_placement? submarine, ["B3", "A3", "C3"]
  end

  def test_it_can_place_ship_with_coords
    submarine = Ship.new "Submarine", 3
    coordinates = ["A1", "A2", "A3"]
    @board.place submarine, coordinates
    coordinates.each do |coordinate|
      assert_equal submarine, @board.cells[coordinate].ship
    end
  end

  def test_it_can_create_valid_rows
    expected = [
                 ["A1", "A2", "A3", "A4"], 
                 ["B1", "B2", "B3", "B4"], 
                 ["C1", "C2", "C3", "C4"], 
                 ["D1", "D2", "D3", "D4"]
               ]
    assert_equal expected, @board.valid_rows
  end

  def test_it_can_create_valid_columns
    expected = [
                 ["A1", "B1", "C1", "D1"], 
                 ["A2", "B2", "C2", "D2"], 
                 ["A3", "B3", "C3", "D3"], 
                 ["A4", "B4", "C4", "D4"]
               ]
    assert_equal expected, @board.valid_columns
  end

  def test_ships_cannot_overlap
    submarine = Ship.new "Submarine", 3
    cruiser = Ship.new "Cruiser", 2
    @board.place submarine, ["A1", "A2", "A3"]
    refute @board.valid_placement? cruiser, ["A1", "B1"]
  end

  def test_it_can_render_board
    submarine = Ship.new "Submarine", 3
    expected = "   1 2 3 4 \n A . . . . "+
                          "\n B . . . . "+
                          "\n C . . . . "+
                          "\n D . . . . \n"
    assert_equal expected, @board.render
  end

  def test_renders_ships
    submarine = Ship.new "Submarine", 3
    @board.place submarine, ["A1", "A2", "A3"]
    expected = "   1 2 3 4 \n A S S S . "+
                          "\n B . . . . "+
                          "\n C . . . . "+
                          "\n D . . . . \n"
    assert_equal expected, @board.render(true)
    cruiser = Ship.new "Cruiser", 2
    @board.place submarine, ["B2", "C2"]
    expected = "   1 2 3 4 \n A S S S . "+
                          "\n B . S . . "+
                          "\n C . S . . "+
                          "\n D . . . . \n"
    assert_equal expected, @board.render(true)
  end

end