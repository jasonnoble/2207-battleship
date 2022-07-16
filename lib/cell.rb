class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @fired_upon = true
    return if empty?
    ship.hit
  end

  def fired_upon?
    @fired_upon
  end

  def render(display = false)
    if empty?
      fired_upon? ? "M" : "."
    else
      if fired_upon?
        ship.sunk? ? "X" : "H"
      else
        display ? "S" : "."
      end
    end
  end
end