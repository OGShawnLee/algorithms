import os { read_lines }

const input_file_path = "./input.txt"

fn main() {
	directions := get_file_lines(input_file_path)!
	floor_number := get_floor_number_from_directions(directions)
	position := get_basement_direction_position(directions)!
	println("Floor Number: $floor_number | Basement Direction Position: $position")
}

fn get_basement_direction_position(lines []string) !int {
	mut floor_number := 0
	for line in lines {
		for index, direction_code in line {
			floor_number += get_direction_code_value(direction_code)
			if floor_number == -1 {
				return index + 1
			}
		}
	}
	panic("Unable to Find Basement Direction Position")
}

fn get_direction_code_value(code u8) int {
	return match code {
		40 { 1 }
		41 { -1 }
		else { 0 }
	}
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or { panic("unable to read file lines from $file_path") }
	return lines
}

fn get_floor_number_from_directions(lines []string) int {
	mut floor_number := 0
	for line in lines {
		for direction_code in line {
			floor_number += get_direction_code_value(direction_code)
		}
	}
	return floor_number
}
