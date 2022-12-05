import math { max, min }
import os { read_lines }

const (
	example_file_path = "./example.txt"
	input_file_path = "./input.txt"
)

fn main() {
	mut lines := get_file_lines(example_file_path)!
	mut contained, mut overlapped := get_contained_and_overlapped_count(lines)
	println("Example Result:")
	println("--> Contained Count: $contained | Overlapped: $overlapped")
	
	lines = get_file_lines(input_file_path)!
	contained, overlapped = get_contained_and_overlapped_count(lines)
	println("Input Result:")
	println("--> Contained Count: $contained | Overlapped: $overlapped")
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or {
		panic("unable to read file lines from $file_path")
	}
	return lines
}

fn get_contained_and_overlapped_count(lines []string) (int, int) {
	mut contained := 0
	mut overlapped := 0
	for line in lines {
		first, second := parse_line_pair(line)
		is_contained := is_contained_in(first, second)
		is_overlapped := is_overlapped_in(first, second)
		if is_contained { contained++ }
		if is_overlapped { overlapped++ }
	} 
	return contained, overlapped
}

fn is_contained_in(first []int, second []int) bool {
	is_first_in_second := first[0] >= second[0] && first[1] <= second[1]
	is_second_in_first := second[0] >= first[0] && second[1] <= first[1]
	return is_first_in_second || is_second_in_first
}

fn is_overlapped_in(a []int, b []int) bool {
	return max(a[0], b[0]) <= min(a[1], b[1])
}

fn parse_line_pair(line string) ([]int, []int) {
	pairs := line.split(",").map(it.split("-").map(it.int()))
	return pairs.first(), pairs.last()
}
