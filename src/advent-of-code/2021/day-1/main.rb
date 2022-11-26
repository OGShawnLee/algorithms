def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_depth_increased_amount lines
  count = 0
  previous_depth = lines[0].to_i
  for depth in lines
    depth = depth.to_i
    if depth > previous_depth 
      count += 1
    end
    previous_depth = depth
  end
  count
end

INPUT_FILE_PATH = "./input.txt"

lines = get_file_lines INPUT_FILE_PATH
increased_count = get_depth_increased_amount lines
puts "times a depth measurement increased from the previous one: #{increased_count}"
