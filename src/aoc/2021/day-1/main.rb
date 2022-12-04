def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_depth_increased_amount_sliding_window lines, window_length
  increased_count = 0
  current_count = 0
  previous_count = 0
  lines.each.with_index do |depth, index|
    depth = depth.to_i
    current_count += depth
    if index >= window_length
      current_count -= lines[index - window_length].to_i
      if current_count > previous_count
        increased_count += 1
      end
      previous_count = current_count
    end
  end
  increased_count
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
SLIDING_WINDOW_LENGTH = 3

lines = get_file_lines INPUT_FILE_PATH
increased_count = get_depth_increased_amount lines
puts "times a depth measurement increased from the previous one: #{increased_count}"
window_increased_count = get_depth_increased_amount_sliding_window lines, SLIDING_WINDOW_LENGTH
puts "#{SLIDING_WINDOW_LENGTH}-sliding-window depth measurement increased count: #{window_increased_count}"
