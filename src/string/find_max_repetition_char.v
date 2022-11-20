fn find_max_repetition_char(str string) (string, int) {
	mut max_code := "".u8()
	mut max_count := 0
	mut code := max_code
	mut count := max_count 
	for c in str {
		if c == code {
			count++
		} else {
			code = c
			count = 1
		}
		if count > max_count {
			max_code = code
			max_count = count
		}
	}
	return max_code.ascii_str(), max_count
}
