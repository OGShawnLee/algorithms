def find_marker_position line, length
  package = []
  line.chars.each.with_index do |letter, index|
    if package.length == length
      return index, package
    end
    if package.include?(letter)
      repeated_index = package.find_index(letter)
      package = package[repeated_index + 1..]
    end
    package.append(letter)
  end
  return -1, package
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def print_results lines, length, type
  puts "- #{type} Start Position:"
  lines.each.with_index do |line, index|
		position, package = find_marker_position(line, length)
		if position == -1
			puts "-- Unable to find Start Position and Package from line #{index}"
		else
			puts "-- Start Position: #{position} | Package: #{package}"
    end
  end
end

FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"
POSITION_LEN_MARKER = 4
POSITION_LEN_MESSAGE = 14

lines = get_file_lines(FILE_PATH_EXAMPLE)
puts "Example File Results:"
print_results(lines, POSITION_LEN_MARKER, "Marker")
print_results(lines, POSITION_LEN_MESSAGE, "Message")
lines = get_file_lines(FILE_PATH_INPUT)
puts "Input File Results:"
print_results(lines, POSITION_LEN_MARKER, "Marker")
print_results(lines, POSITION_LEN_MESSAGE, "Message")
