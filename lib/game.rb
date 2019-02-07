require_relative 'dialogue'
require_relative 'player'
require_relative 'computer'
require_relative 'ship'

class Game
  include Dialogue
  attr_reader :ready, :player, :computer

  def intialize
    @ready = false
    @player = nil
    @computer = nil
  end

  def menu
    if initial_greeting 
      @ready = true  
      start_game(request_size_message)
    else
      cancel_game_message
    end
  end

  def start_game size
    @computer = Computer.new(size)
    @player = Player.new(size)
    initialize_ship_message
    place_ship_stage
  end

  def place_ship_stage
    @player.initialize_ship_placement
    @computer.initialize_ship_placement
    ready_message
    fire_missiles_stage
  end

  def fire_missiles_stage
    computer_info = @computer.recieve_shot(@player.guess)
    player_info = @player.recieve_shot(@computer.guess)
    render_board("Player", @player.board.render(true))
    shot_response_feedback(*player_info)
    render_board("Computer", @computer.board.render)
    shot_response_feedback(*computer_info)
    end_game?
  end

  def end_game?
    computer_win = @player.ships.all? {|ship| ship.health == 0}
    player_win = @computer.ships.all? {|ship| ship.health == 0}
    if computer_win || player_win
      end_game_message(player_win, computer_win)
      @ready = false
    else
      fire_missiles_stage 
    end
  end
end
