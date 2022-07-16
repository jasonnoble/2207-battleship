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
    return if empty?
    @fired_upon = true
    ship.hit
  end

  def fired_upon?
    @fired_upon
  end
end