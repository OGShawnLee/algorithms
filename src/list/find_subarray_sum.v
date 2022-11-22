fn find_subarray_sum(list []int, sum int) [][]int {
	mut sublist_list := [][]int {}
	mut current_sum := 0
	mut current_sum_start_index := 0
	for index, element in list {
		current_sum += element
		if current_sum > sum {
			current_sum -= list[current_sum_start_index]
			current_sum_start_index++
		}
		if current_sum == sum {
			sublist_list << list[current_sum_start_index..index + 1]
		}
	}
	return sublist_list
}

input := [10, 30, 20, 20, 10, 10, 10, 10]
mut sublists := find_subarray_sum(input, 40)
assert sublists == [[10, 30], [20, 20], [20, 10, 10], [10, 10, 10, 10]]
sublists = find_subarray_sum(input, 20)
assert sublists == [[20], [20], [10, 10], [10, 10], [10, 10]]
sublists = find_subarray_sum(input, 30)
assert sublists == [[30], [20, 10], [10, 10, 10], [10, 10, 10]]
