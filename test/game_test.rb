require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/computer'
require './lib/player'
require_relative 'gets_chomp'

class GameTest < MiniTest::Test
  include GetsChomp
  def setup
    @game = Game.new
  end
  
  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_menu
    with_stdin do |player|
      player.puts "q"
      @game.menu
      refute @game.ready
      
      player.puts "p"
      @game.menu
      assert @game.ready
    end
  end

  def test_start_game_creates_player_and_computer
    @game.start_game
    assert_instance_of Computer, @game.computer
    assert_instance_of Player, @game.player
  end

  def test_fire_missiles_stage
    with_stdin do |player|
      player.puts "A1"
      @game.start_game
      player.puts "p"
      assert @game.ready

    end
    binding.pry
  end
end