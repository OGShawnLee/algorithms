def get_desired_sublist_sum(arr: list[int], desired_sum: int):
  output: list[list[int]] = []
  count = 0
  sum_start_index = 0
  for index, element in enumerate(arr):
    count += element
    while count > desired_sum:
      count -= arr[sum_start_index]
      sum_start_index += 1
    if count == desired_sum:
      output.append(arr[sum_start_index:index + 1])
  return output
