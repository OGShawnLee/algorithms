module string	

import regex

pub fn get_duplicate_count(str string) ?int {
	lower_str := remove_whitespace(str)?.to_lower()
	unique_str := to_unique_str(lower_str)
	mut count := 0
	for code in unique_str {
		if is_duplicate_str(code, lower_str) { count++ }
	}
	return count
}

fn is_duplicate_str(char_code u8, str string) bool {
	mut count := 0
	for code in str {
		if count > 1 { return true }
		if code == char_code { count++ }
	}
	return count > 1
}

fn remove_whitespace(str string) ?string {
	mut re := regex.regex_opt(r"\s")?
	return re.replace(str, '')
}

fn to_unique_str(str string) string {
	mut cache := map[u8]bool {}
	mut unique_str := ""
	for code in str {
		if code in cache { continue }
		cache[code] = true
		unique_str += code.ascii_str()
	}
	return unique_str
}