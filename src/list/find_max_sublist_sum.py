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

input = [-10, -20, 10, 20, -10, -50, 10, 20, 40, -20]
assert find_max_sublist_sum(input) == 70
input = [-5, -10, 40, 5, -5, 10, -90]
assert find_max_sublist_sum(input) == 50
