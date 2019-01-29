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
  end

  def valid_coordinate? coordinate
    @cells.keys.include?(coordinate)
  end

  def valid_placement? ship, coordinates
    return false if ship.length != coordinates.length
    letters = Array.new(4, ("A".."D").to_a)
    numbers = Array.new(4, (1..4).to_a)
    valid_column = letters.map.with_index {|letters_a, index|
      letters_a.map {|letter|
        "#{letter}#{numbers[index][index]}"
      }
    }
    valid_row = valid_column.transpose

    [valid_row, valid_column].reduce(false) {|boolean, valids_array|
      target_valid = valids_array.find {|valid_array| valid_array.include?(coordinates.first)}
      indices = coordinates.map {|coordinate| target_valid.index(coordinate)}
      boolean = indices.each_cons(2).all? {|a, b| b == a + 1 }
      return boolean if boolean
    }
  end

end