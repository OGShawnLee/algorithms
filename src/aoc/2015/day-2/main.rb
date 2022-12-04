def calculate_box_ribbon length, width, height
  ribbon = length * 2 + width * 2
  bow = length * width * height
  ribbon + bow
end

def calculate_box_wrapping_paper length, width, height
  (2 * length * width) + (2 * width * height) + (2 * height * length) + length * width
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_total_wrapping_paper lines
  ribbon = 0
  paper = 0
  for line in lines
    length, width, height = parse_present_dimensions line
    paper += calculate_box_wrapping_paper length, width, height
    ribbon += calculate_box_ribbon length, width, height
  end
  return paper, ribbon
end 

def parse_present_dimensions line
  numbers = line.split("x").map { |char| char.to_i } 
  numbers.sort { |a, b| a <=> b }
end

INPUT_FILE_NAME = "./input.txt"

dimensions = get_file_lines INPUT_FILE_NAME
paper, ribbon = get_total_wrapping_paper dimensions
puts "Total Wrapping Paper: #{paper} square feet | Total Ribbon: #{ribbon} feet"
