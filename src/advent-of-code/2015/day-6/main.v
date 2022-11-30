import os { read_lines }
import regex { regex_opt }
import math { min, max }

const input_path = "./input.txt"
const example_path = "./example.txt"

fn main() {
	count := get_total_lit_lights(input_path)!
	println("Total Lit Lights: $count")
}

fn create_matrix(size int) [][]int {
	return [][]int { 
		cap: size, 
		len: size, 
		init: []int { cap: size, len: size, init: -1 }
	}
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or {
		panic("Unable to read lines from $file_path")
	}
	return lines
}

fn get_instruction_light_count(mut matrix [][]int, line string) !int {
	instruction, start, end := parse_line(line)!
	mut count := 0
	match instruction {
		"toggle" {
			count += use_instruction_light_change(start, end, fn [mut matrix] (row_index int, column_index int) int {
				light := matrix[row_index][column_index]
				matrix[row_index][column_index] = if light == 1 { -1 } else { 1 }
				return matrix[row_index][column_index]
			})
		}
		"turn on" {
			count += use_instruction_light_change(start, end, fn [mut matrix] (row_index int, column_index int) int {
				light := matrix[row_index][column_index]
				if light == 1 { return 0 }
				matrix[row_index][column_index] = 1
				return matrix[row_index][column_index]
			})
		}
		"turn off" {
			count += use_instruction_light_change(start, end, fn [mut matrix] (row_index int, column_index int) int {
				light := matrix[row_index][column_index]
				if light == -1 { return 0 }
				matrix[row_index][column_index] = -1
				return matrix[row_index][column_index]
			})
		}
		else { 
			panic("$instruction is an Invalid Instruction!") 
		}
	}
	return count
}

fn get_total_lit_lights(file_path string) !int {
	lines := get_file_lines(file_path)!
	mut matrix := create_matrix(1000)
	mut count := 0
	for line in lines {
		light_count := get_instruction_light_count(mut matrix, line)!
		count += light_count
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
