def get_coordinate_key x, y
  x.to_s + y.to_s
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_visited_houses_count lines
  visited_houses = {}
  x = 0
  y = 0
  for line in lines
    for char in line.split("")
      key = get_coordinate_key x, y
      visited_houses[key] = true
      if is_horizontal_line char
        x += COORDINATE_VALUES[char.to_sym]
      elsif is_vertical_line char
        y += COORDINATE_VALUES[char.to_sym]
      end
    end
  end
  visited_houses.length
end

def is_horizontal_line char
  char == ">" or char == "<"
end

def is_vertical_line char
  char == "^" or char == "v"
end

COORDINATE_VALUES = { "^": 1, "v": -1, ">": 1, "<": -1 }
INPUT_FILE_NAME = "./input.txt"

lines = get_file_lines INPUT_FILE_NAME
count = get_visited_houses_count lines
puts "Visited Houses: #{count}"