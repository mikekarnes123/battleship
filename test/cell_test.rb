require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require 'pry'

class CellTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @cell = Cell.new("B4")
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_initially_has_a_coordinate_and_does_not_have_a_ship
    assert_equal "B4", @cell.coordinate
    assert_nil @cell.ship
  end

  def test_it_reports_if_the_cell_is_empty
    assert @cell.empty?
  end

  def test_it_reports_not_empty_if_ship_is_placed_on_cell
    assert @cell.empty?
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    refute @cell.empty?
  end

  def test_if_it_has_been_fired_upon
    refute @cell.fired_upon?
  end

  def test_it_can_fire_upon
    @cell.fire_upon
    assert @cell.fired_upon?
  end

  def test_that_the_ship_on_the_cell_takes_damage
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
  end

end