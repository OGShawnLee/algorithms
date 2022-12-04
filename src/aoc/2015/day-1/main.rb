def get_basement_direction_position lines
  floor_number = 0
  for line in lines
    line.split("").each.with_index do |char, index|
      floor_number += get_direction_char_value char
      if floor_number == -1
        return index + 1
      end
    end
  end
  raise "Unable to Find Basement Direction Position"
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_floor_number_from_directions lines
  floor_number = 0
  for line in lines
    for char in line.split("")
      floor_number += get_direction_char_value char
    end
  end
  floor_number
end

def get_direction_char_value char
  char == "(" ? 1 : char == ")" ? -1 : 0
end

INPUT_FILE_NAME = "./input.txt"

directions = get_file_lines INPUT_FILE_NAME
floor_number = get_floor_number_from_directions directions
position = get_basement_direction_position directions
puts "Floor Number: #{floor_number} | Basement Direction Position: #{position}"
