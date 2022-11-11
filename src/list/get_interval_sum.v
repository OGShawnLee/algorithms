module list

pub fn get_interval_sum_recursive(mut intervals [][]int) int {
	mut total := 0
	for index, mut interval in intervals {
		minimum := interval[0]
		maximum := interval[1]
		for i := index + 1; i < intervals.len; i++ {
			inner_interval := intervals[i]
			mini := inner_interval[0]
			maxi := inner_interval[1]
			if is_overlapped(interval, inner_interval) {
				interval[0] = min(minimum, mini)
				interval[1] = max(maximum, maxi)
				intervals.delete(i)
				return get_interval_sum_recursive(mut intervals)
			} 
		} 
		total += maximum - minimum
	}
	return total
}

fn is_overlapped(a []int, b []int) bool {
  return max(a[1], b[1]) - min(a[0], b[0]) < a[1] - a[0] + (b[1] - b[0])
}

fn max(a int, b int) int {
	return if a > b { a } else { b }	
}

fn min(a int, b int) int {
	return if a > b { b } else { a }
}