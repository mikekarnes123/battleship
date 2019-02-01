require_relative 'cell'

class Board
  attr_reader :cells, :occupied_cells
  
  def initialize
    @cells = ("A".."D").inject({}) do |cell_hash, letter|
      (1..4).each do |num|
       coordinate = "#{letter}#{num}"
        cell_hash[coordinate] = Cell.new(coordinate)
      end
      cell_hash
    end
    @occupied_cells = []
  end

  def valid_coordinate? coordinate
    @cells.keys.include?(coordinate)
  end

  def valid_placement? ship, coordinates
    return false if ship.length != coordinates.length
    overlapping = coordinates.any? { |coordinate| @occupied_cells.include?(coordinate) }
    return false if overlapping
    [valid_rows, valid_columns].reduce(false) do |consecutive, valids_array|
      target_valid = valids_array.find { |array| array.include?(coordinates.first) }
      indices = coordinates.map { |coordinate| target_valid.index(coordinate) }
      indices.sort_by! {|num| num} if indices.all?
      consecutive = indices.each_cons(2).all? { |a, b| b == a + 1 }
      return consecutive if consecutive
    end
  end

  def valid_rows
    letters, numbers = ("A".."D").to_a, Array.new(4, (1..4).to_a)
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
      respective_letter = ("A".."D").to_a[index]
      rendered_rows.unshift(respective_letter) << "\n"
    end.join(" ")
    "   1 2 3 4 \n #{rendered_board}"
  end
end