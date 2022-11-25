import os { read_lines }

const input_file_path = "./input.txt"

fn main() {
	lines := get_file_lines(input_file_path)!
	wrapping_paper := get_total_wrapping_paper(lines)
	println("Total Wrapping Paper: $wrapping_paper square feet")
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or { 
		panic("unable to read file lines from $file_path") 
	}
	return lines
}

fn calculate_present_wrapping_paper(line string) int {
	length, width, height := parse_present_dimensions(line)
	slack := length * width
	return (2 * length * width) + (2 * width * height) + (2 * height * length) + slack 
}

fn get_total_wrapping_paper(lines []string) int {
	mut wrapping_paper := 0
	for line in lines {
		wrapping_paper += calculate_present_wrapping_paper(line)
	}	
	return wrapping_paper
}

fn parse_present_dimensions(line string) (int, int, int) {
	mut dimensions := line.split("x").map(it.int())
	dimensions.sort()
	return dimensions[0], dimensions[1], dimensions[2]
}
