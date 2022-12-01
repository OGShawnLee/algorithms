import os { read_lines }
import regex { regex_opt }
import math { min, max }

const input_path = "./input.txt"
const example_path = "./example.txt"

fn main() {
	count_thread := spawn get_total_lit_lights(input_path)
	brightness_thread := spawn get_total_light_brightness(input_path)
	count := count_thread.wait()!
	brightness := brightness_thread.wait()!
	println("Total Lit Lights: $count")
	println("Total Light Brightness: $brightness")
}

fn create_matrix(size int, value int) [][]int {
	return [][]int { 
		cap: size, 
		len: size, 
		init: []int { cap: size, len: size, init: value }
	}
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or {
		panic("Unable to read lines from $file_path")
	}
	return lines
}

fn get_instruction_brightness_count(mut matrix [][]int, line string) !int {
	return use_instruction_matching(
		line,
		fn [mut matrix] (row_index int, column_index int) int {
			matrix[row_index][column_index] += 2
			return 2
		}, 
		fn [mut matrix] (row_index int, column_index int) int {
			matrix[row_index][column_index]++
			return 1
		}, 
		fn [mut matrix] (row_index int, column_index int) int {
			brightness := matrix[row_index][column_index]
			if brightness == 0 { return 0 }
			matrix[row_index][column_index]--
			return -1
		}
	)
}

fn get_instruction_light_count(mut matrix [][]int, line string) !int {
	return use_instruction_matching(
		line,
		fn [mut matrix] (row_index int, column_index int) int {
			light := matrix[row_index][column_index]
			matrix[row_index][column_index] = if light == 1 { -1 } else { 1 }
			return matrix[row_index][column_index]
		},
		fn [mut matrix] (row_index int, column_index int) int {
			light := matrix[row_index][column_index]
			if light == 1 { return 0 }
			matrix[row_index][column_index] = 1
			return matrix[row_index][column_index]
		},
		fn [mut matrix] (row_index int, column_index int) int {
			light := matrix[row_index][column_index]
			if light == -1 { return 0 }
			matrix[row_index][column_index] = -1
			return matrix[row_index][column_index]
		}
	)
}

fn get_total_lit_lights(file_path string) !int {
	lines := get_file_lines(file_path)!
	mut matrix := create_matrix(1000, -1)
	mut count := 0
	for line in lines {
		light_count := get_instruction_light_count(mut matrix, line)!
		count += light_count
	}
	return count
}

fn get_total_light_brightness(file_path string) !int {
	lines := get_file_lines(file_path)!
	mut matrix := create_matrix(1000, 0)
	mut count := 0
	for line in lines {
		brightness := get_instruction_brightness_count(mut matrix, line)!
		count += brightness
	}
	return count
}

fn parse_line(line string) !(string, []int, []int) {
	coordinates_query := r"\d+,\d+"
	instruction_query := "(toggle)|(turn (on)|(off))"
	mut re := regex_opt(coordinates_query) or { panic(err) }
	coordinates := re.find_all_str(line).map(it.split(",").map(it.int()))
	re = regex_opt(instruction_query) or { panic(err) }
	instruction := re.find_all_str(line)[0]
	return instruction, coordinates[0], coordinates[1]
}

fn use_instruction_light_change(start []int, end []int, func fn (int, int) int) int {
	mut change := 0
	for row_index in start[0]..end[0] + 1 {
		for column_index in start[1]..end[1] + 1 {
			change += func(row_index, column_index)
		}
	} 
	return change
}

fn use_instruction_matching(
	line string,
	on_toggle fn (int, int) int,
	on_turn_on fn (int, int) int,
	on_turn_off fn (int, int) int
) !int {
	instruction, start, end := parse_line(line)!
	mut count := 0
	match instruction {
		"toggle" {
			count += use_instruction_light_change(start, end, on_toggle)
		}
		"turn on" {
			count += use_instruction_light_change(start, end, on_turn_on)
		}
		"turn off" {
			count += use_instruction_light_change(start, end, on_turn_off)
		}
		else {
			panic("$instruction is an Invalid Instruction!")
		}
	}
	return count
}
