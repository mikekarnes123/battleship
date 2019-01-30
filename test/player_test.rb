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
    @player.ships.each {|ship|
      assert_instance_of Ship, ship
    }
    assert_instance_of Board, @player.board
  end

  def test_it_can_place_player_ships_onto_the_board
    @player.place_ships
    assert_equal 5, @player.board.occupied_cells.length
  end

end
