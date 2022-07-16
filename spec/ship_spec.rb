require './lib/ship'

RSpec.describe Ship do
  describe '#new(name, length)' do
    it 'creates a Ship'
  end

  describe '#name' do
    it 'provides the name of the ship'
  end
  describe '#length' do
    it 'provides the length of the ship'
  end
  describe '#health' do
    it 'provides the current health of the ship'
  end
  describe '#sunk?' do
    it 'returns false when health > 0'
    it 'returns true when health == 0'
  end
  describe '#hit' do
    it 'decreases health by 1'
    it 'does not decrease health if the ship is sunk'
  end
end