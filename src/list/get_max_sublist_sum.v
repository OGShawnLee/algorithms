fn get_max_sublist_sum(input []int, length int) []int {
	mut current_sum := 0
	mut max_sum := 0
	mut max_sum_start_index := 0
	for index, element in input {
		current_sum += element
		if index < length {
			max_sum = current_sum
		} else {
			current_sum -= input[index - length]
			if current_sum > max_sum {
				max_sum = current_sum
				max_sum_start_index = index - length + 1
			}
		}
	}
	return input[max_sum_start_index..max_sum_start_index + length]
}
