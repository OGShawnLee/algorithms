def find_marker_position line
  package = []
  line.chars.each.with_index do |letter, index|
    if package.include?(letter)
      repeated_index = package.find_index(letter)
      package = package[repeated_index + 1..]
    end
    if package.length == 4
      return index, package
    end
    package.append(letter)
  end
  return -1, package
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def print_results lines
  lines.each.with_index do |line, index|
		position, package = find_marker_position(line)
		if position == -1
			puts "Unable to find Start Position and Package from line #{index}"
		else
			puts "Start Position: #{position} | Package: #{package}"
    end
  end
end

FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"

lines = get_file_lines(FILE_PATH_EXAMPLE)
print_results(lines)
lines = get_file_lines(FILE_PATH_INPUT)
print_results(lines)
