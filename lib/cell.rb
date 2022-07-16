class Cell
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    ship.nil?
  end

  def place_ship(ship)
    @ship = ship
    @fired_upon = false
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
    return '.' if empty? && !fired_upon?
    return 'S' if !empty? && display && !fired_upon?
    return 'M' if empty?
    ship.sunk? ? "X" : "H"
  end
end