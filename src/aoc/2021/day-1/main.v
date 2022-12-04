import os

const input_path = "./input.txt"

fn main() {
	increased_count := get_depth_increased_amount(input_path)
	println("times a depth measurement increased from the previous one: $increased_count")
	window_increased_count := get_depth_sliding_window_increased_amount(input_path, 3)
	println("3-sliding-window depth measurement increased count: $window_increased_count")
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

fn get_depth_sliding_window_increased_amount(file_path string, window_length int) int {
	lines := get_file_lines(file_path)
	mut increased_count := 0
	mut previous_sum := 0
	mut current_sum := 0
	for index, line in lines {
		current_sum += line.int()
		if index >= window_length {
			current_sum -= lines[index - window_length].int()			
			if current_sum > previous_sum {
				increased_count++
			}
			previous_sum = current_sum
		}
	}
	return increased_count
}

fn get_file_lines(file_path string) []string {
	lines := os.read_lines(file_path) or { panic("unable to read file lines") }
	return lines
}