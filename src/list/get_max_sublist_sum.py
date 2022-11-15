def get_max_sublist_sum(arr: list[int], length: int):
  max_count = 0
  max_count_start_index = 0
  current_count = 0
  for index, element in enumerate(arr):
    current_count += element
    if index < length:
      max_count = current_count
    else:
      current_count -= arr[index - length]
      if current_count > max_count:
        max_count = current_count
        max_count_start_index = index - length + 1
  return arr[max_count_start_index:max_count_start_index + length]
