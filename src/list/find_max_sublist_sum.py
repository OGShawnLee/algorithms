import sys

# Kadane's
def find_max_sublist_sum(arr: list[int]):
  maximum = ~sys.maxsize
  current = 0
  for element in arr:
    current += element
    current = max(current, element)
    maximum = max(current, maximum)
  return maximum

def find_max_sublist_sum_bruteforce(list: list[int]):
  count = 0
  for index in range(0, len(list)):
    for idx in range(index, len(list)):
      local_count = 0
      for i in range(index, idx): 
        local_count += list[i]
      count = max(count, local_count)
  return count

input = [-10, -20, 10, 20, -10, -50, 10, 20, 40, -20]
assert find_max_sublist_sum(input) == 70
assert find_max_sublist_sum_bruteforce(input) == 70
input = [-5, -10, 40, 5, -5, 10, -90]
assert find_max_sublist_sum(input) == 50
assert find_max_sublist_sum_bruteforce(input) == 50
