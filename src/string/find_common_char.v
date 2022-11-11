module string

struct CharCount {
	letter string
	count int
}

pub fn find_common_char(str string) CharCount {
	mut cache := map[u8]CharCount {}
	mut common := get_char_count(str[0], str)
	cache[str[0]] = common
	for code in str {
		if code in cache { continue }
		char_count := get_char_count(code, str)
		cache[code] = char_count
		if char_count.count > common.count {
			common = char_count
		} 
	} 
	return common
}

fn get_char_count(char_code u8, str string) CharCount {
	mut count := 0
	for code in str {
		if code == char_code { count++ }
	}
	return CharCount { char_code.ascii_str(), count }
}