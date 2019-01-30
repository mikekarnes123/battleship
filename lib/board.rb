require 'pry'
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

  def place ship, coordinates
    coordinates.each do |coordinate|
      @cells[coordinate].ship = ship
      @occupied_cells << coordinate
    end
  end

  def render(boolean=false)
    if !boolean
      "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    else
      rows = [["A1", "A2", "A3", "A4"],["B1", "B2", "B3", "B4"],["C1", "C2", "C3", "C4"],["D1", "D2", "D3", "D4"]]
      rendered_board = rows.map.with_index {|row_array, index|
      row_array.map {|coord|
        if @occupied_cells.include? coord
          @cells[coord].render(true)
        else
          @cells[coord].render
        end
      }.unshift(("A".."D").to_a[index]) << "\n"
    }.join(" ")
    "   1 2 3 4 \n #{rendered_board}"

    end

  end


end
