import os { read_lines }
import strconv { parse_int }

struct ByteCount {
	mut: 
		on int
		off int
}

fn (mut counter ByteCount) count(code u8) {
	if code == 49 { counter.on++ } else { counter.off++ }
}

fn (counter ByteCount) get_common_byte() u8 {
	return if counter.on >= counter.off { u8(49) } else { u8(48) } 
}

fn (counter ByteCount) get_uncommon_byte() u8 {
	return if counter.on >= counter.off { u8(48) } else { u8(49) } 
}

const file_path = "./input.txt"

fn main() {
	power := get_submarine_power_consumption(file_path)!
	println("submarine power consumption: $power")
	life_support_rating := get_life_support_ratings(file_path)!
	println("life support rating: $life_support_rating")
}

fn get_gamma_and_epsilon_rate(lines []string) (string, string) {
	mut counts := []ByteCount { len: 12, cap: 12, init: ByteCount{ 0, 0 } }
	mut gamma_rate := ""
	mut epsilon_rate := ""
	for line in lines {
		for index, code in line {
			if code == 49 {
				counts[index].on++
			} else {
				counts[index].off++
			}
		}
	}
	for count in counts {
		if count.on > count.off { 
			gamma_rate += "1"
			epsilon_rate += "0"
		} else { 
			gamma_rate += "0"
			epsilon_rate += "1"
		}
	}
	return gamma_rate, epsilon_rate
}

fn get_submarine_power_consumption(file_path string) !i64 {
	lines := get_file_lines(file_path)!
	gamma_rate, epsilon_rate := get_gamma_and_epsilon_rate(lines) 
	gamma_int := handle_binary_str_to_int(gamma_rate, "gamma_rate")!
	epsilon_int := handle_binary_str_to_int(epsilon_rate, "epsilon_rate")!
	return gamma_int * epsilon_int
}

fn get_submarine_carbon_rate(file_path string) !i64 {
	mut lines := get_file_lines(file_path)!
	mut counters := []ByteCount { len: 12, cap: 12, init: ByteCount{} }
	for index, mut counter in counters {
		if lines.len == 1 { break }
		for line in lines { counter.count(line[index]) }
		lines = lines.filter(it[index] == counter.get_uncommon_byte()) 
	}
	rate := lines[0]
	return handle_binary_str_to_int(rate, "carbon scrubber rating")!
}

fn get_submarine_oxygen_rate(file_path string) !i64 {
	mut lines := get_file_lines(file_path)!
	mut counters := []ByteCount { len: 12, cap: 12, init: ByteCount{ } }
	for index, mut counter in counters {
		if lines.len == 1 { break }
		for line in lines { counter.count(line[index]) }
		lines = lines.filter(it[index] == counter.get_common_byte()) 
	}
	rate := lines[0]
	return handle_binary_str_to_int(rate, "oxygen generator rating")!
}

fn get_life_support_ratings(file_path string) !i64 {
	carbon_rating := get_submarine_carbon_rate(file_path)!
	oxygen_rating := get_submarine_oxygen_rate(file_path)!
	return carbon_rating * oxygen_rating
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or { panic("unable to read file lines") }
	return lines
}

fn handle_binary_str_to_int(binary_str string, variable_name string) !i64 {
	return parse_int(binary_str, 2, 16) or { 
		panic("unable to convert $variable_name binary string to an integer") 
	}
}