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

def get_contained_count lines
  count = 0
  for line in lines
    a, b = parse_line_pair(line)
    contained = is_contained_in(a, b) 
    count += 1 if contained 
  end
  count
end

def is_contained_in a, b
  is_a_in_b = a[0] >= b[0] && a[1] <= b[1]
  is_b_in_a = b[0] >= a[0] && b[1] <= a[1] 
  is_a_in_b || is_b_in_a
end

lines = get_file_lines(EXAMPLE_PATH)
count = get_contained_count(lines)
puts "Example Results:"
puts "-> Contained Count: #{count}"

lines = get_file_lines(INPUT_PATH)
count = get_contained_count(lines)
puts "Input Results:"
puts "-> Contained Count: #{count}"