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
  describe '#fired_upon?' do
    before do
      cell.place_ship(cruiser)
    end
    it 'returns false when it has not been fired on' do
      expect(cell).not_to be_fired_upon
    end

    it 'returns true when it has been fired on' do
      cell.fire_upon
      expect(cell).to be_fired_upon
    end
  end
  describe '#fire_upon' do
    context 'with a ship' do
      before do
        cell.place_ship(cruiser)
      end
      it 'decreases the ships health' do
        expect{ cell.fire_upon }.to change(cruiser, :health).from(3).to(2)
      end
    end
  end
  describe '#render' do
    context 'when the cell has not been fired upon' do
      it 'renders as "." if debug == false (default)' do
        expect(cell.render).to eq('.')
      end
      context 'when the cell has a ship' do
        before do
          cell.place_ship(cruiser)
        end
        it 'renders as "." if debug == false (default)' do
          expect(cell.render).to eq('.')
        end
        it 'renders as "S" if debug == true and has a ship' do
          
          expect(cell.render(true)).to eq('S')
        end
      end

    end

    context 'when the cell has been fired upon' do
      before do
        cell.fire_upon
      end

      it 'renders as "M" if there is no ship' do
        expect(cell.render).to eq("M")
      end

      context 'when the cell has a ship' do
        before do
          cell.place_ship(cruiser)
        end
        it 'renders as "H" if the ship is not sunk' do
          expect(cell.render).to eq("H")
        end
        it 'renders as "X" if the ship is sunk' do
          3.times { cruiser.hit }
          expect(cell.render).to eq("X")
        end
      end
    end
  end
end