EXAMPLE_PATH = "./example.txt"
INPUT_PATH = "./input.txt" 

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def parse_line_pair line
  line.split(",").map do |pair| 
    pair.split("-").map { |char| char.to_i } 
  end
end

def get_contained_and_overlapped_count lines
  contained = 0
  overlapped = 0
  for line in lines
    a, b = parse_line_pair(line)
    is_contained = is_contained_in(a, b) 
    is_overlapped = is_overlapped_in(a, b)
    contained += 1 if is_contained
    overlapped += 1 if is_overlapped 
  end
  return contained, overlapped
end

def is_contained_in a, b
  is_a_in_b = a[0] >= b[0] && a[1] <= b[1]
  is_b_in_a = b[0] >= a[0] && b[1] <= a[1] 
  is_a_in_b || is_b_in_a
end

def is_overlapped_in a, b
  max(a[0], b[0]) <= min(a[1], b[1])
end

def max a, b
  a > b ? a : b
end

def min a, b
  a > b ? b : a
end

lines = get_file_lines(EXAMPLE_PATH)
contained, overlapped = get_contained_and_overlapped_count(lines)
puts "Example Results:"
puts "-> Contained Count: #{contained} | Overlapped: #{overlapped}"

lines = get_file_lines(INPUT_PATH)
contained, overlapped = get_contained_and_overlapped_count(lines)
puts "Input Results:"
puts "-> Contained Count: #{contained} | Overlapped: #{overlapped}"