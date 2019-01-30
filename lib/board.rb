class Board
  attr_reader :cells
  
  def initialize
    @cells = ("A".."D").inject({}) {|cell_hash, letter|
      (1..4).each {|num|
       coordinate = "#{letter}#{num}"
        cell_hash[coordinate] = Cell.new(coordinate)
      }
      cell_hash
    }
    @letters = Array.new(4, ("A".."D").to_a)
    @numbers = Array.new(4, (1..4).to_a)
    @occupied_cells = []
  end

  def valid_coordinate? coordinate
    @cells.keys.include?(coordinate)
  end

  def valid_placement? ship, coordinates
    return false if ship.length != coordinates.length
    occupied = false
    coordinates.each do |coord|
      occupied = true if @occupied_cells.include?(coord)
    end
    return !occupied if occupied
    valid_column = @letters.map.with_index {|letters_a, index|
      letters_a.map { |letter|
        "#{letter}#{@numbers[index][index]}"
      }
    }
    valid_row = valid_column.transpose
    [valid_row, valid_column].reduce(false) { |boolean, valids_array|
      target_valid = valids_array.find { |valid_array| valid_array.include?(coordinates.first) }
      indices = coordinates.map { |coordinate| target_valid.index(coordinate) }
      boolean = indices.each_cons(2).all? { |a, b| b == a + 1 }
      return boolean if boolean
    }
  end

  def place ship, coordinates
    coordinates.each { |coordinate|
      @cells[coordinate].place_ship(ship)
      @occupied_cells << coordinate
    }
  end

  def render(boolean=false)
    if !boolean
      "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    else
     rows = @numbers.map.with_index { |numbers_a, index|
        numbers_a.map { |number|
          "#{@letters[index][index]}#{number}"
        }
      }
      rendered_board = rows.map.with_index { |row_array, index|
      rendered_rows = row_array.map { |coordinate|
        @occupied_cells.include?(coordinate) ? @cells[coordinate].render(true) : @cells[coordinate].render
      }
      rendered_rows.unshift(("A".."D").to_a[index]) << "\n"
    }.join(" ")
    "   1 2 3 4 \n #{rendered_board}"
    end
  end


end
