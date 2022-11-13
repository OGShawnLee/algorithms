def find_max_sequence_sum(input: list[int]) -> int:
  if len(input) == 0: return 0
  count = 0
  for index in range(0, len(input)):
    for idx in range(index, len(input)):
      local_count = 0
      for i in range(index, idx + 1):
        local_count += input[i]
      if local_count > count: 
        count = local_count
  return count
