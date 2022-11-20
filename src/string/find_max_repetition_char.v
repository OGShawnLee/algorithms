struct Cache {
	mut:
		letter u8
		count int
}

fn find_max_repetition_char(str string) (string, int) {
	if str.len == 0 { return "", 0 }
	mut max := Cache{ str[0], 1 }
	mut current := Cache{ str[0], 1 }
	for index in 1..str.len {
		letter := str[index]
		if letter == current.letter {
			current.count++
		} else {
			current.letter = letter
			current.count = 1
		}
		if current.count > max.count {
			max.letter = current.letter
			max.count = current.count
		}
	}
	return max.letter.ascii_str(), max.count
}

