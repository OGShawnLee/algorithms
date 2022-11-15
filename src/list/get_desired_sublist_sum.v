fn get_sublist_desired_sum(input []int, desired_sum int) [][]int {
	mut output := [][]int {}
	mut sum := 0
	mut sum_start_index := 0
	for index, element in input {
		sum += element
		for sum > desired_sum {
			sum -= input[sum_start_index]
			sum_start_index++
		}
		if sum == desired_sum {
			output << input[sum_start_index..index + 1]
		}
	}
	return output
}
