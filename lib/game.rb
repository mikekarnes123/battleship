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
    @player.initialize_ship_placement
    @computer.initialize_ship_placement
    puts "\n"
    puts "\n"
    
    render_board("Computer", @computer.board.render)
    ready_message
    fire_missiles_stage
  end

  def fire_missiles_stage

    @computer.recieve_shot(@player.guess)
    @player.recieve_shot(@computer.guess)
    render_board("Player", @player.board.render(true))
    puts "\n"
    puts "\n"
    render_board("Computer", @computer.board.render)
    end_game?
  end

  def end_game?
    if @player.ships.all? {|ship| ship.health == 0}
      puts "The Computer Has Won :("
    elsif @computer.ships.all? {|ship| ship.health == 0}
      puts "You Win!!! :)"
    else
      fire_missiles_stage
    end
  end
end
