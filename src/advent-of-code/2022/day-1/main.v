import math { max }
import os { read_lines }

const input_path = "./input.txt"

fn main() {
	max_calories := find_max_elf_calories(input_path)!
	println("Maximum Elf Calories: $max_calories")
}

fn find_max_elf_calories(file_path string) !int  {
	lines := get_file_lines(file_path) or {
		panic("unable to find maximum elf calories -> $err")
	}
	mut current_elf_calories := 0
	mut max_elf_calories := 0
	for line in lines {
		if line == "" {
			max_elf_calories = max(max_elf_calories, current_elf_calories)
			current_elf_calories = 0
		} else {
			current_elf_calories += line.int()
		}
	}
	return max_elf_calories
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or {
		panic("unable to read file lines from $file_path")
	}
	return lines
}
