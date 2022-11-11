module list

pub fn move_zeros_to_the_end(mut list []int) []int {
	for index, mut external in list {
		if external != 0 { continue }
		for i := index + 1; index < list.len; i++ {
			internal := list[i] or { return list }
			if internal == 0 { continue } 
			list[i] = 0
			external = internal
			break
		}
	}
	return list
}