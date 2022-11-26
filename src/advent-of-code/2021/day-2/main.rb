def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_submarine_position lines
  depth = 0
  forward = 0
  for line in lines
    direction, value = parse_line line
    case direction
    when "forward"
     forward += value 
    when "up" 
      depth -= value
    when "down"
      depth += value
    else
      raise "#{direction} is an invalid direction" 
    end
  end
  depth * forward
end

def parse_line line
  direction, value = line.split(" ")
  return direction, value.to_i
end

INPUT_FILE_PATH = "./input.txt"

lines = get_file_lines INPUT_FILE_PATH
position = get_submarine_position lines
puts "Submarine Position: #{position}"
