require 'pry'
class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship ? false : true
  end

  def place_ship ship
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @ship.hit if @ship; @fired_upon = true
  end

  def render boolean = nil
    case fired_upon?
      when false
        !boolean || !boolean && !@ship ? "." : "S" 
      else
        !@ship ? 'M' : @ship.health == 0 ? 'X' : "H"
    end
  end
end
