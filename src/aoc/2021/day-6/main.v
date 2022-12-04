import arrays { flat_map }
import os { read_lines }

const (
	example_file_path = "./example.txt"
	input_file_path = "./input.txt"
	day_limit = 80
)

struct Lanternfish {
	mut: 
		count int
		is_newborn bool 
}

fn main() {
	mut school := get_lanternfish_school(example_file_path)!
	mut population := get_lanternfish_population(mut school, day_limit)
	println("Example Results:")
	println("lanternfish: $population")

	school = get_lanternfish_school(input_file_path)!
	population = get_lanternfish_population(mut school, day_limit)
	println("Input Results:")
	println("lanternfish: $population")
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or { panic("unable to read file lines from $file_path") }
	return lines
}

fn get_lanternfish_school(file_path string) ![]Lanternfish {
	lines := get_file_lines(file_path)!
	return flat_map<string, Lanternfish>(lines, fn (line string) []Lanternfish {
		return line.split(",").map(Lanternfish { count: it.int() })
	})
}

fn get_lanternfish_population(mut school []Lanternfish, day_limit int) int {
	mut day := 0
	for day < day_limit {
		day++
		for mut lanternfish in school {
			if lanternfish.is_newborn {
				lanternfish.is_newborn = false
				continue
			}
			if lanternfish.count == 0 {
				lanternfish.count = 6
				school << Lanternfish { 8, true }
			} else if lanternfish.count <= 8 {
				lanternfish.count--
			}
		}
	}
	return school.len
}
