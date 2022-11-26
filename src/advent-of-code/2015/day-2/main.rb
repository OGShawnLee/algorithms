def calculate_box_wrapping_paper length, width, height
  (2 * length * width) + (2 * width * height) + (2 * height * length) + length * width
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_total_wrapping_paper lines
  paper = 0
  for line in lines
    length, width, height = parse_present_dimensions line
    paper += calculate_box_wrapping_paper length, width, height
  end
  paper
end 

def parse_present_dimensions line
  numbers = line.split("x").map do |char|
    char.to_i
  end
  numbers.sort { |a, b| a <=> b }
end

INPUT_FILE_NAME = "./input.txt"

dimensions = get_file_lines INPUT_FILE_NAME
paper = get_total_wrapping_paper dimensions
puts "Total Wrapping Paper: #{paper} square feet"
