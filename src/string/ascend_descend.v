module string

pub fn ascend_descend(len int, min int, max int) string {
	if len <= 0 || min > max { return "" }
	if min == max { return min.str().repeat(len).substr(0, len)  }
	mut num := min
	mut num_str := num.str()
	mut str := ""
	mut is_going_up := num < max
	for index := 0; str.len < len; index++ {
		if is_going_up {
			num++
			if num == max { is_going_up = false }
		} else {
			num--
			if num == min { is_going_up = true }	
		}
		str += num_str
		num_str = num.str()
	}
	return str.substr(0, len)
}