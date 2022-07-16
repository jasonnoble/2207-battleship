require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  let(:cell) { Cell.new("B4") }
  let(:cruiser) { Ship.new("Cruiser", 3) }

  describe '#new(coordinate)' do
    it 'creates a new cell' do
      expect(cell).to be_a(Cell)
    end
  end
  describe '#coordinate' do
    it 'returns the cell coordinate' do
      expect(cell.coordinate).to eq("B4")
    end
  end
  describe '#ship' do
    it 'returns the ship' do
      expect(cell.ship).to eq(nil)
    end
  end
  describe '#empty?' do
    context 'when a ship has not been placed' do
      it 'returns false' do
        expect(cell).to be_empty
      end
    end
    context 'when a ship has been placed' do
      it 'returns true' do
        cell.place_ship(cruiser)
        expect(cell).not_to be_empty
      end
    end
  end
  describe '#place_ship(ship)' do
    it 'places the ship' do
      expect{ cell.place_ship(cruiser) }.to change(cell, :empty?).from(true).to(false)
    end
  end

end