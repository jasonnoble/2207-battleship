require './lib/board'
require './lib/ship'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:cruiser) { Ship.new("Cruiser", 3) }
  let(:submarine) { Ship.new("Submarine", 2) }

  describe '#new' do
    it 'creates a board' do
      expect(board).to be_a(Board)
    end
  end

  describe '#cells' do
    it 'has 16 keys' do
      expect(board.cells.keys.length).to eq(16)
    end
    it 'has 16 Cell instances as values' do
      expect(board.cells.values.all?(Cell)).to be_truthy
    end
  end

  describe '#valid_coordinate?(coordinate)' do
    it 'returns true when valid' do
      expect(board).not_to be_valid_coordinate("A5")
    end
    it 'returns valse when invalid' do
      expect(board).to be_valid_coordinate("A1")
    end
  end

  describe '#valid_placement?(ship, coordinates)' do
    it 'returns false when the ship length != coordinates length' do
      expect(board).not_to be_valid_placement(cruiser, ["A1", "A2"])
    end
    context 'when coordinates are in the same row' do
      it 'returns false when columns are non consecutive' do
        expect(board).not_to be_valid_placement(cruiser, ["A3", "A2", "A1"])
      end
      it 'returns true when columns are consecutive' do
        expect(board).to be_valid_placement(cruiser, ["A1", "A2", "A3"])
      end
    end

    context 'when coordinates are in the same column' do
      it 'returns false when rows are non consecutive' do
        expect(board).not_to be_valid_placement(cruiser, ["A1", "C1", "D1"])
      end
      it 'returns true when rows are consecutive' do
        expect(board).to be_valid_placement(cruiser, ["A1", "B1", "C1"])
      end
    end

    it 'returns false when rows and columns are not the same' do
      expect(board).not_to be_valid_placement(cruiser, ["A1", "B2", "C3"])
    end
  end
end