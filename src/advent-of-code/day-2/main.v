import os

fn main() {
	position := get_submarine_position("./input.txt")
	println("submarine position: $position")
}

fn get_submarine_position(file_path string) int {
	lines := get_file_lines(file_path)
	mut forward := 0
	mut depth := 0
	for line in lines {
		parsed_line := line.split(" ")
		direction := parsed_line[0]
		value := parsed_line[1].int()
		match direction {
			"forward" { forward += value }
			"up" { depth -= value }
			"down" { depth += value }
			else {
				panic("'$direction' is an invalid direction")
			}
		}
	}
	return forward * depth
}

fn get_file_lines(file_path string) []string {
	lines := os.read_lines(file_path) or { panic("unable to read file lines") }
	return lines
}

