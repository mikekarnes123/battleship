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
    @ship.health -= 1 if @ship
    @fired_upon = true
  end

  def render(boolean = false)
    if boolean
      "S"
    else

      if @fired_upon && !@ship
        "M"
      elsif @fired_upon && @ship
        return "X" if @ship.health == 0

        "H"
      else
        "."
      end
  end
end

end
