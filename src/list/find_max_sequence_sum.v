module list

pub fn find_max_sequence_sum(input []int) int {
	if input.len == 0 { return 0 }
	mut count := 0
	for index := 0; index < input.len; index++ {
		for idx := index; idx < input.len; idx++ {
			mut total := 0
			for i := index; i <= idx; i++ { 
				total += input[i] 
			}
			if total > count { 
				count = total 
			}
		}
	}
	return count
}