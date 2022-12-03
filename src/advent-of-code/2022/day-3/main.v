import os { read_lines }

const (
	example_path = "./example.txt"
	input_path = "./input.txt"
	letters = "abcdefghijklmnopqrstuvwxyz" 
	uppercase_letters = letters.to_upper()
)

fn main() {
	input_count_thread := go get_items_priority_sum(input_path)
	example_count_thread := go get_items_priority_sum(example_path)
	mut count := example_count_thread.wait()!
	println("Example Prority Sum: $count")
	count = input_count_thread.wait()!
	println("Input Prority Sum: $count")
}

fn find_repeated_char(line string) !u8 {
	first_half := line.substr(0, line.len / 2)
	second_half := line.substr(line.len / 2, line.len)
	for first_item_char in first_half {
		for second_item_char in second_half {
			if first_item_char == second_item_char { 
				return first_item_char
			}		
		}
	}
	panic("unable to find duplicate item $line")
}

fn get_char_priority(char_code u8) !int {
	for index, code in letters {
		if char_code == code { return index + 1 }
		upper_code := uppercase_letters[index]
		if char_code == upper_code { return index + 1 + 26 }
	}
	panic("unable to find priority of $char_code")
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or {
		panic("unable to read lines from $file_path")
	}
	return lines
}

fn get_items_priority_sum(file_path string) !int {
	mut count := 0
	lines := get_file_lines(file_path)!
	for line in lines {
		code := find_repeated_char(line)!
		priority := get_char_priority(code)!
		count += priority
	} 
	return count
}