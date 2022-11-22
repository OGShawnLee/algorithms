import math

// #Kadane's
fn find_max_sublist_sum(list []int) int {
	mut maximum := math.min_i32
	mut current := 0
	for element in list {
		current += element
		current = math.max(current, element)
		maximum = math.max(maximum, current) 
	}
	return maximum
}

fn find_max_sublist_sum_bruteforce(list []int) int {
	mut count := 0
	for index := 0; index < list.len; index++ {
		for idx := index; idx < list.len; idx++ {
			mut local_count := 0
			for i := index; i <= idx; i++ { 
				local_count += list[i] 
			}
			count = math.max(count, local_count)
		}
	}
	return count
}

mut input := [-10, -20, 10, 20, -10, -50, 10, 20, 40, -20]
assert find_max_sublist_sum(input) == 70
assert find_max_sublist_sum_bruteforce(input) == 70
input = [-5, -10, 40, 5, -5, 10, -90]
assert find_max_sublist_sum(input) == 50
assert find_max_sublist_sum_bruteforce(input) == 50
