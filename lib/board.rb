require_relative 'cell'

class Board
  attr_reader :cells, :occupied_cells, :size

  def initialize(size)
    letters = (1..size).map {|num| (num + 64).chr}
    @size = size
    @cells = letters.inject({}) do |cell_hash, letter|
      (1..size).each do |num|
        coordinate = "#{letter}#{num}"
        cell_hash[coordinate] = Cell.new(coordinate)
      end
      cell_hash
    end
    @occupied_cells = []
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false if ship.length != coordinates.length
    return false if overlapping?(coordinates)
    consecutive?(coordinates)
  end

  def overlapping?(coordinates)
    coordinates.any? { |coordinate| @occupied_cells.include?(coordinate) }
  end

  def consecutive?(coordinates)
    [valid_rows, valid_columns].reduce(false) do |consecutive, valids_array|
      target_valid = valids_array.find { |array| array.include?(coordinates.first) }
      indices = coordinates.map { |coordinate| target_valid.index(coordinate) }
      indices.all? ? indices.sort! : next
      consecutive = indices.each_cons(2).all? { |a, b| b == a + 1 }
      return true if consecutive
      return consecutive
    end
  end

  def valid_rows
    numbers = Array.new(@size, (1..@size).to_a)
    letters = (1..@size).map {|num| (num + 64).chr}
    numbers.map.with_index do |numbers_a, index|
      numbers_a.map do |number|
        "#{letters[index]}#{number}"
      end
    end
  end

  def valid_columns
    valid_rows.transpose
  end

  def place ship, coordinates
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
      @occupied_cells << coordinate
    end
  end

  def render boolean = false
    rendered_board = valid_rows.map.with_index do |row_array, index|
      rendered_rows = row_array.map do |coordinate|
        if @occupied_cells.include?(coordinate) && boolean
          @cells[coordinate].render(true)
        else
          @cells[coordinate].render
        end
      end
      letters = (1..@size).map {|num| (num + 64).chr}
      respective_letter = letters[index]
      rendered_rows.unshift(respective_letter) << "\n"
    end.join(" ")
    "   #{(1..@size).to_a.join(" ")} \n #{rendered_board}"
  end
end
