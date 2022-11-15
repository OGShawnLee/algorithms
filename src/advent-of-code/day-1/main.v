import os

const input_path = "./input.txt"

fn main() {
	lines := get_file_lines(input_path)
	mut increased_count := 0
	mut previous_depth := lines[0].int()
	for line in lines {
		depth := line.int()
		if depth > previous_depth { increased_count++ }
		previous_depth = depth
	}
	println("times a depth measurement increased from the previous one: $increased_count")
}

fn get_file_lines(file_path string) []string {
	lines := os.read_lines(file_path) or { panic("unable to read file lines") }
	return lines
}