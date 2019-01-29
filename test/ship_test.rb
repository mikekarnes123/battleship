require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_initially_has_name_length_and_health

    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.health
    assert_equal 3, @cruiser.length

  end

  def test_it_reports_if_sunk
    refute @cruiser.sunk?
  end

  def test_that_hit_will_change_status_of_sunk
    refute @cruiser.sunk?
    @cruiser.hit
    assert @cruiser.sunk?
  end


end
