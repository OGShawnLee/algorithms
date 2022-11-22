def find_subarray_sum(input: list[int], sum: int):
  output: list[list[int]] = []
  current_sum = 0
  current_index = 0
  for index, number in enumerate(input):
    current_sum += number
    if current_sum > sum:
      current_sum -= input[current_index]
      current_index += 1
    if current_sum == sum:
      output.append(input[current_index:index + 1])
  return output

input = [10, 30, 20, 20, 10, 10, 10, 10]
sublists = find_subarray_sum(input, 40)
assert sublists == [[10, 30], [20, 20], [20, 10, 10], [10, 10, 10, 10]]
sublists = find_subarray_sum(input, 20)
assert sublists == [[20], [20], [10, 10], [10, 10], [10, 10]]
sublists = find_subarray_sum(input, 30)
assert sublists == [[30], [20, 10], [10, 10, 10], [10, 10, 10]]
