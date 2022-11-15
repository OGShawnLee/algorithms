import os

const input_path = "./input.txt"

fn main() {
	increased_count := get_depth_increased_amount(input_path)
	println("times a depth measurement increased from the previous one: $increased_count")
}

fn get_depth_increased_amount(file_path string) int {
	lines := get_file_lines(file_path)
	mut increased_count := 0
	mut previous_depth := lines[0].int()
	for line in lines {
		depth := line.int()
		if depth > previous_depth { increased_count++ }
		previous_depth = depth
	}
	return increased_count
}

fn get_file_lines(file_path string) []string {
	lines := os.read_lines(file_path) or { panic("unable to read file lines") }
	return lines
}