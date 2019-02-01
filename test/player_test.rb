require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'
require './lib/ship'
require './lib/board'
require_relative 'gets_chomp'
require 'pry'


class PlayerTest < MiniTest::Test
  include GetsChomp
  def setup
    @player = Player.new
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_it_initially_has_ships_board
    @player.ships.each do |ship|
      assert_instance_of Ship, ship
    end
    assert_instance_of Board, @player.board
  end

  def test_it_can_place_player_ships_onto_the_board
    with_stdin do |player|
      player.puts "A1"
      player.puts "A2"
      @player.place_player_ship @player.ships[0]
      assert_equal ["A1", "A2"], @player.board.occupied_cells
    end
  end

  def test_initialize_placement_method
    with_stdin do |player|
      player.puts "A1"
      player.puts "A2"
      player.puts "B1"
      player.puts "B2"
      player.puts "B3"

      @player.initialize_ship_placement

      assert_equal ["A1", "A2", "B1", "B2", "B3"], @player.board.occupied_cells
    end
  end

  def test_can_get_player_coordinate_guess
    with_stdin do |player|
      player.puts "A1"
      assert_equal "A1", @player.guess
      assert @player.player_guesses.include? "A1"
      end
  end

  def test_player_cannot_repeat_guesses
    with_stdin do |player|
      player.puts "A1"
      player.puts "A1"
      player.puts "A2"
      @player.guess
      assert @player.player_guesses.include? "A1"
      @player.guess
      assert_equal ["A1", "A2"], @player.player_guesses
      end
  end

  def test_can_be_shot_at
    @player.recieve_shot "A1"
    assert @player.board.cells["A1"].fired_upon?
  end
end
