import os { read_lines }

const (
	example_path = "./example.txt"
	input_path = "./input.txt"
)

fn main() {
	mut lines := get_file_lines(example_path)!
	print_results(lines)
	lines = get_file_lines(input_path)!
	print_results(lines)
}

fn find_starter_marker_position(line string) (int, []string) {
	mut list := []u8 { cap: 4 }
	for index, code in line {
		if code in list {
			code_index := list.index(code)
			list.drop(code_index + 1)
		}
		if list.len == 4 {
			return index, list.map(it.ascii_str())
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

fn print_results(lines []string) {
	for index, line in lines {
		position, package := find_starter_marker_position(line)
		if position == -1 {
			println('Unable to find Start Position and Package from line $index')
		} else {
			println('Start Position: $position | Package: $package')
		}
	}
}