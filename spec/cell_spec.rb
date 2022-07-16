require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  let(:cell) { Cell.new("B4") }
  let(:cruiser) { Ship.new("Cruiser", 3) }

  describe '#new(coordinate)' do
    it 'creates a new cell' 
  end
  describe '#coordinate'
  describe '#ship'
  describe '#empty?'
  describe '#place_ship(ship)'

end