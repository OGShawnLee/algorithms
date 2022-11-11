module list

pub fn move_zeros_to_the_end(mut list []int) []int {
	for index, mut external in list {
		if external != 0 { continue }
		for i := index + 1; i < list.len; i++ {
			internal := list[i]
			if internal == 0 { continue } 
			list[i] = 0
			external = internal
			break
		}
	}
	return list
}