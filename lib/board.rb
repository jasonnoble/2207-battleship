require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {}
    ('A'..'D').each do |row|
      (1..4).each do |column|
        @cells[row + column.to_s] = Cell.new(row + column.to_s)
      end
    end
  end

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false if ship.length != coordinates.length
    return false if coordinates.any?{|coordinate| !valid_coordinate?(coordinate)}
    return true if coordinates_in_same_row?(coordinates) && columns_consecutive?(coordinates)
    return true if coordinates_in_same_column?(coordinates) && rows_consecutive?(coordinates)
    return false
  end

  private

  def coordinates_in_same_row?(coordinates)
    coordinates.map{|coordinate| coordinate[0] == coordinates[0][0]}.all?
  end

  def coordinates_in_same_column?(coordinates)
    coordinates.all?{|coordinate| coordinate[1] == coordinates[0][1]}
  end

  def columns_consecutive?(coordinates)
    coordinate_columns = coordinates.map{|coordinate| coordinate[1]}.map(&:to_i)
    coordinate_columns.each_cons(2).map do |column_1, column_2|
      column_1.next == column_2
    end.all?
  end

  def rows_consecutive?(coordinates)
    coordinate_rows = coordinates.map{|coordinate| coordinate[0]}
    coordinate_rows.each_cons(2).map do |row_1, row_2|
      row_1.next == row_2
    end.all?
  end
end