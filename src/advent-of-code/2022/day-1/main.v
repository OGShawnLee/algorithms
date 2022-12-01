import math { max }
import os { read_lines }

const input_path = "./input.txt"

fn main() {
	lines := get_file_lines(input_path)!
	max_calories_future := spawn find_max_elf_calories(lines)
	top_3_future := spawn find_top_3_max_elf_calories(lines)
	max_calories := max_calories_future.wait()
	println("Maximum Elf Calories: $max_calories")
	first, second, third := top_3_future.wait()
	total := first + second + third
	println("Top 3 Maximum Elf Calories: $first, $second, $third | Total: $total")
}

fn insert_calories(current int, mut calories []int) {
	if current > calories.first() {
		calories.prepend(current)
		calories.delete_last()
	} else if current > calories[1] {
		calories.insert(1, current)
		calories.delete_last()
	} else if current > calories.last() {
		calories[calories.len - 1] = current
	}
}

fn find_top_3_max_elf_calories(lines []string) (int, int, int) {
	mut calories := []int { cap: 3, len: 3, init: 0 }
	mut current := 0
	for line in lines {
		if line == "" {
			insert_calories(current, mut calories)
			current = 0
		} else {
			current += line.int()
		}
	}
	insert_calories(current, mut calories)
	return calories[0], calories[1], calories[2]
}

fn find_max_elf_calories(lines []string) int {
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
