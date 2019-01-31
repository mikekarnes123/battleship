require_relative 'dialogue'
require_relative 'player'
require_relative 'computer'
require_relative 'ship'



class Game
  include Dialogue

  attr_accessor :ready, :player, :computer

  def intialize
    @ready = false
    @player = nil
    @computer = nil
  end

  def menu
    initial_greeting ? @ready = true : end_game_message
  end

  def start_game
    @computer = Computer.new
    @player = Player.new
    initialize_ship_message
    place_ship_stage
  end
  
  def place_ship_stage 
    @player.get_coordinates
    @computer.place_ships
    render_board("Computer", @computer.board.render)
    fire_missiles_stage
  end

  def fire_missiles_stage
    coordinate = fire_missles_message
    @computer.fired_on(coordinate)
    @player.fired_on(@computer.random_shot)
    render_board("Player", @player.board.render(true))
    render_board("Computer", @computer.board.render)
  end
end