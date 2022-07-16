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

    it 'returns false when a coordinate is invalid' do
      expect(board).not_to be_valid_placement(cruiser, ["Y1", "Y2", "Y3"])
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

    it 'returns false if any coordinates already have a ship' do
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board).not_to be_valid_placement(submarine, ["A1", "B1"])
    end
  end

  describe '#place(ship, coordinates)' do
    context 'when valid_placement?' do
      it 'places the ship at the coordinates' do
        board.place(cruiser, ["A1", "A2", "A3"])
        expect(board.cells["A1"].ship).to eq(cruiser)
        expect(board.cells["A2"].ship).to eq(cruiser)
        expect(board.cells["A3"].ship).to eq(cruiser)
      end
    end

    context 'when not valid_placement?' do
      it 'does not place the ship' do
        board.place(cruiser, ["A1", "A2", "A3"])
        board.place(submarine, ["A1", "B1"])
        expect(board.cells["B1"]).to be_empty
      end
    end
  end
end