import os { read_lines }

const (
	example_path = "./example.txt"
	input_path = "./input.txt"
	marker_len = 4
	message_len = 14
)

fn main() {
	mut lines := get_file_lines(example_path)!
	print("Example File Results:")
	print_results(lines, marker_len, "Marker")
	print_results(lines, message_len, "Message")
	lines = get_file_lines(input_path)!
	print("Input File Results:")
	print_results(lines, marker_len, "Marker")
	print_results(lines, message_len, "Message")
}

fn find_marker_position(line string, len int) (int, []string) {
	mut list := []u8 { cap: 4 }
	for index, code in line {
		if list.len == len {
			return index, list.map(it.ascii_str())
		}
		if code in list {
			code_index := list.index(code)
			list.drop(code_index + 1)
		}
		list << code
	}
	return -1, list.map(it.ascii_str())
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or {
		panic("Unable to read file lines from $file_path")
	}
	return lines
}

fn print_results(lines []string, len int, operation string) {
	println("- $operation Start Position")
	for index, line in lines {
		position, package := find_marker_position(line, len)
		if position == -1 {
			println('-- Unable to find Start Position and Package from line $index')
		} else {
			println('-- Start Position: $position | Package: $package')
		}
	}
}