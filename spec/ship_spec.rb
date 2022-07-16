require './lib/ship'

RSpec.describe Ship do
  let(:cruiser) { Ship.new("Cruiser", 3) }
  describe '#new(name, length)' do
    it 'creates a Ship' do
      expect(cruiser).to be_a(Ship)
    end
  end

  describe '#name' do
    it 'provides the name of the ship' do
      expect(cruiser.name).to eq("Cruiser")
    end
  end
  describe '#length' do
    it 'provides the length of the ship' do
      expect(cruiser.length).to eq(3)
    end
  end
  describe '#health' do
    it 'provides the current health of the ship' do
      expect(cruiser.health).to eq(3)
    end
  end
  describe '#sunk?' do
    it 'returns false when health > 0' do
      expect(cruiser).to_not be_sunk
    end
    it 'returns true when health == 0' do
      3.times { cruiser.hit }
      expect(cruiser).to be_sunk
    end
  end
  describe '#hit' do
    it 'decreases health by 1' do
      expect{ cruiser.hit }.to change(cruiser, :health).by(-1)
    end
    it 'does not decrease health if the ship is sunk' do
      cruiser.hit # => health = 2
      cruiser.hit # => health = 1
      cruiser.hit # => health = 0, sunk == true
      expect{ cruiser.hit }.not_to change(cruiser, :health)
    end
  end
end