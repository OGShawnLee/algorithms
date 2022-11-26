import os { read_lines }

const (
	code_values = { 94: 1, 118: -1, 62: 1, 60: -1 }
	input_file_path = "./input.txt"
)

fn main() {
	lines := get_file_lines(input_file_path)!
	count := get_visited_houses_count(lines)
	println("Visited Houses: $count")
}

fn get_coordinate_key(x int, y int) string {
	return x.str() + y.str()
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or { 
		panic("unable to read file lines from $file_path") 
	}
	return lines
}

fn get_visited_houses_count(lines []string) int {
	mut visited_coordinates := map[string]bool {}
	mut x := 0 
	mut y := 0 
	for line in lines {
		for code in line {
			key := get_coordinate_key(x, y)
			visited_coordinates[key] = true
			if is_horizontal_direction(code) {
				x += code_values[code]
			} else if is_vertical_direction(code) {
				y += code_values[code]
			}
		}
	}
	return visited_coordinates.len
}

fn is_horizontal_direction(code u8) bool {
	return code == 62 || code == 60
}

fn is_vertical_direction(code u8) bool {
	return code == 94 || code == 118
}
