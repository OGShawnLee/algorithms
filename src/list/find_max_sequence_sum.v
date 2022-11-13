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

// found on the internet
fn fast_find_max_sequence_sum(input []int) int {
    mut min := 0 
    mut ans := 0 
    mut sum := 0
    for index := 0; index < input.len; index++ {
        sum += input[index]
        min = math.min(sum, min)
        ans = math.max(ans, sum - min)
    }
    return ans
}