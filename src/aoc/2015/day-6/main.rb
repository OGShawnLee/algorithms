def create_matrix size, matrix_value
  Array.new(size) { Array.new(size, matrix_value) }
end

def get_instruction_light_brightness line, matrix
  change = 0
  instruction, root, peak = parse_line(line)
  case instruction
  when "toggle"
    change += use_instruction_light_change(root, peak) do |row_index, column_index|
      matrix[row_index][column_index] += 2
      2
    end
  when "turn on"
    change += use_instruction_light_change(root, peak) do |row_index, column_index|
      matrix[row_index][column_index] += 1
      1
    end
  when "turn off"
    change += use_instruction_light_change(root, peak) do |row_index, column_index|
      brightness = matrix[row_index][column_index]
      if brightness == 0
        0
      else
        matrix[row_index][column_index] -= 1
        -1
      end
    end
  else
    raise "#{instruction} is an Invalid Instruction!"
  end
  change
end

def get_instruction_light_count line, matrix
  change = 0
  instruction, root, peak = parse_line(line)
  case instruction
  when "toggle"
    change += use_instruction_light_change(root, peak) do |row_index, column_index|
      light_state = matrix[row_index][column_index]
      matrix[row_index][column_index] = light_state == 1 ? -1 : 1
    end
  when "turn on"
    change += use_instruction_light_change(root, peak) do |row_index, column_index|
      light_state = matrix[row_index][column_index]
      light_state == 1 ? 0 : matrix[row_index][column_index] = 1
    end
  when "turn off"
    change += use_instruction_light_change(root, peak) do |row_index, column_index|
      light_state = matrix[row_index][column_index]
      light_state == -1 ? 0 : matrix[row_index][column_index] = -1
    end
  else
    raise "#{instruction} is an Invalid Instruction!"
  end
  change
end

def get_lit_lights_count file_path, matrix_size
  lines = get_file_lines(file_path)
  matrix = create_matrix(matrix_size, -1)
  count = 0
  for line in lines
    count += get_instruction_light_count(line, matrix)
  end
  count
end

def get_lights_brightness file_path, matrix_size
  lines = get_file_lines(file_path)
  matrix = create_matrix(matrix_size, 0)
  count = 0
  for line in lines
    count += get_instruction_light_brightness(line, matrix)
  end
  count
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def parse_line line
  root, peak = line.scan(/(\d+),(\d+)/).map { |matches| matches.map { |char| char.to_i } }
  instruction = /((\w+ (on|off))|(\w+))/.match(line).captures[0]
  return instruction, root, peak
end

def use_instruction_light_change root, peak 
  change = 0
  (root[0]..peak[0]).each do |row_index|
    (root[1]..peak[1]).each do |column_index|
      change += yield row_index, column_index
    end
  end
  change
end

INPUT_FILE = "./input.txt"
MATRIX_SIZE = 1000

count = get_lit_lights_count(INPUT_FILE, MATRIX_SIZE)
puts "Input Total Lit Lights: #{count}"
brightness = get_lights_brightness(INPUT_FILE, MATRIX_SIZE)
puts "Input Light Brightness: #{brightness}"
