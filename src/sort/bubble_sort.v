fn bubble_sort(mut list []int) []int {
	for i in 0..list.len {
		for j in i + 1..list.len {
			element := list[i]
			item := list[j]
			if item < element {
				list[i] = item
				list[j] = element
			}
		}
	}
	return list
}
	
mut input := [1, 3, 4, 2, 5, 7, 6]
assert bubble_sort(mut input) == [1, 2, 3, 4, 5, 6, 7]
input = [-5, 4, 3, 2, -4, 5, -3, -2, -1, 0, 1]
assert bubble_sort(mut input) == [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]
input = [20, -10, 5, -15, 15, -20, 10]
assert bubble_sort(mut input) == [-20, -15, -10, 5, 10, 15, 20]
