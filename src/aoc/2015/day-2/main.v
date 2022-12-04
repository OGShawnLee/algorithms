import os { read_lines }

const input_file_path = "./input.txt"

fn main() {
	lines := get_file_lines(input_file_path)!
	paper, ribbon := get_total_wrapping_paper_and_ribbon(lines)
	println("Total Wrapping Paper: $paper square feet | Total Ribbon: $ribbon feet")
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or { 
		panic("unable to read file lines from $file_path") 
	}
	return lines
}

fn calculate_present_wrapping_paper(length int, width int, height int) int {
	slack := length * width
	return (2 * length * width) + (2 * width * height) + (2 * height * length) + slack 
}

fn calculate_present_ribbon(length int, width int, height int) int {
	ribbon := length * 2 + width * 2 
	bow := length * width * height
	return ribbon + bow
}

fn get_total_wrapping_paper_and_ribbon(lines []string) (int, int) {
	mut wrapping_paper := 0
	mut ribbon := 0
	for line in lines {
		length, width, height := parse_present_dimensions(line)
		wrapping_paper += calculate_present_wrapping_paper(length, width, height)
		ribbon += calculate_present_ribbon(length, width, height)
	}	
	return wrapping_paper, ribbon
}

fn parse_present_dimensions(line string) (int, int, int) {
	mut dimensions := line.split("x").map(it.int())
	dimensions.sort()
	return dimensions[0], dimensions[1], dimensions[2]
}
