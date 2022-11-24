import os { read_lines }
import math { min, max }

const (
	example_file_path = "./example.txt"
	input_file_path = "./input.txt"
)

fn main() {
	mut lines := get_file_lines(example_file_path)!
	mut matrix := create_matrix(10)
	mut coordinates := get_line_coordinates(lines)
	mut count := get_overlapped_count(mut matrix, coordinates)
	println("Example File Results")
	print_matrix(matrix)
	println("--> Overlapped Count $count")
	lines = get_file_lines(input_file_path)!
	matrix = create_matrix(1000)
	coordinates = get_line_coordinates(lines)
	count = get_overlapped_count(mut matrix, coordinates)
	println("Input File Results")
	println("--> Overlapped Count $count")
}

fn create_matrix(size int) [][]int {
	return [][]int {
		cap: size,
		len: size,
		init: []int { cap: size, len: size, init: 0 }
	}
}

fn get_diagonal_coordinates(start []int, end []int) [][]int {
	mut x_minimum, mut x_maximum := minmax(start[0], end[0]) 
	mut y_minimum, mut y_maximum := minmax(start[1], end[1]) 
	is_x_ascending := start[0] < end[0] 
	is_y_ascending := start[1] < end[1]
	coordinates_length := x_maximum + 1 - x_minimum
	mut coordinates := [][]int{ 
		cap: coordinates_length, 
		len: coordinates_length, 
		init: []int { cap: 2, len: 2, init: 0 } 
	}
	handle_x := if is_x_ascending {
		fn [mut x_minimum] (mut pair []int) {
			pair[0] = x_minimum
			x_minimum++
		}
	} else {
		fn [mut x_maximum] (mut pair []int) {
			pair[0] = x_maximum
			x_maximum--
		}
	}
	handle_y := if is_y_ascending {
		fn [mut y_minimum] (mut pair []int) {
			pair[1] = y_minimum
			y_minimum++
		}
	} else {
		fn [mut y_maximum] (mut pair []int) {
			pair[1] = y_maximum
			y_maximum--
		}
	}
	for mut pair in coordinates {
		handle_x(mut pair)
		handle_y(mut pair)
	}
	return coordinates
}

fn get_line_coordinates(lines []string) [][][]int {
	mut coordinates := [][][]int{}
	for line in lines {
		coordinates << line.split(" -> ").map(it.split(",").map(it.int()))
	}
	return coordinates
}

fn get_overlapped_count(mut matrix [][]int, coordinates [][][]int) int {
	mut overlapped_count := 0
	for pair in coordinates {
		start := pair[0] 
		end := pair[1]
		if is_horizontal_line(start, end) {
			mut row := matrix[start[1]]
			minimum, maximum := minmax(start[0], end[0])
			for column_index in minimum..maximum + 1 {
				row[column_index]++
				tile := row[column_index]
				if tile == 2 { overlapped_count++ }
			}
		} else if is_vertical_line(start, end) {
			column_index := start[0]
			minimum, maximum := minmax(start[1], end[1])
			for row_index in minimum..maximum + 1 {
				matrix[row_index][column_index]++
				tile := matrix[row_index][column_index]
				if tile == 2 { overlapped_count++ }
			} 
		} else {
			diagonal_coordinates := get_diagonal_coordinates(start, end)
			for coordinate in diagonal_coordinates {
				column_index := coordinate[0]
				row_index := coordinate[1]
				matrix[row_index][column_index]++
				tile := matrix[row_index][column_index] 
				if tile == 2 { overlapped_count++ }
			}
		}
	}
	return overlapped_count
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or { panic("unable to read file lines") }
	return lines
}

fn is_horizontal_line(start []int, end []int) bool {
	return start[1] == end[1]
}

fn is_vertical_line(start []int, end []int) bool {
	return start[0] == end[0]
}

fn minmax<T>(a T, b T) (T, T) {
	return min(a, b), max(a, b)
}

fn print_matrix(matrix [][]int) {
	for row in matrix {
		letters := row.map(it.str())
		mut first_row_str := letters[0]
		for index in 1..letters.len {
			letter := letters[index].str()
			first_row_str += "\t$letter"
		}
		println(first_row_str)
	}
}
