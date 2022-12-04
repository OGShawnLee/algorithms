import os { read_lines }

const (
	example_path = "./example.txt"
	input_path = "./input.txt"
	letters = "abcdefghijklmnopqrstuvwxyz" 
	uppercase_letters = letters.to_upper()
)

fn main() {
	input_lines := get_file_lines(input_path)!
	example_lines := get_file_lines(example_path)!
	input_count_thread := go get_items_priority_sum(input_lines)
	example_count_thread := go get_items_priority_sum(example_lines)
	mut count := example_count_thread.wait()!
	println("Example Prority Sum: $count")
	count = input_count_thread.wait()!
	println("Input Prority Sum: $count")
	input_priority_count := go get_common_group_items_priority_count(input_lines)
	example_priority_count := go get_common_group_items_priority_count(example_lines)
	mut priority_count := example_priority_count.wait()!
	println("Example Prority Sum: $priority_count")
	priority_count = input_priority_count.wait()!
	println("Input Prority Sum: $priority_count")
}

fn get_common_group_items_priority_count(lines []string) !int {
	mut current_group := []string { cap: 3 }
	mut priority_count := 0
	for line in lines {
		if current_group.len != 3 {
			current_group << line
		}
		if current_group.len == 3 {
			common_char := find_common_group_item_char(current_group)!
			priority := get_char_priority(common_char)!
			priority_count += priority
			current_group.clear()
		}
	}
	return priority_count
}

fn find_common_group_item_char(group []string) !u8 {
	for index, code in letters {
		upper_code := uppercase_letters[index]
		is_common_upper_char := group.all(it.index_u8(upper_code) != -1)
		if is_common_upper_char { return upper_code }
		is_common_char := group.all(it.index_u8(code) != -1)
		if is_common_char { return code }
	}
	panic("unable to find common group item char in $group")
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

fn get_items_priority_sum(lines []string) !int {
	mut count := 0
	for line in lines {
		code := find_repeated_char(line)!
		priority := get_char_priority(code)!
		count += priority
	} 
	return count
}