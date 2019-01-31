require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/ship'
require './lib/board'


class PlayerTest < MiniTest::Test
  def setup
    @player = Player.new
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_it_initially_has_ships_board
    @player.ships.each { |ship|
      assert_instance_of Ship, ship
    }
    assert_instance_of Board, @player.board
  end

  def test_it_can_place_player_ships_onto_the_board
    ["A1", "A2"].each {|coord|
      ship = @player.ships[0]
      @player.place_ship(ship, ["A1", "A2"])
      assert_equal ship, @player.board.cells[coord].ship
      assert_equal ship.name, @player.board.cells[coord].ship.name
      assert_equal ship.length, @player.board.cells[coord].ship.length
    }

  end

end
