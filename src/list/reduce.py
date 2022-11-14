from collections.abc import Callable

def reduce(input: list[int], initial_value: int, fn: Callable[[int, int], int]):
  output: list[int] = []
  if len(input) == 0: return output
  output.append(fn(initial_value, input[0]))
  for index in range(1, len(input)):
    output.append(fn(output[index - 1], input[index]))
  return output

def gcd(a: int, bar: int):
  a = abs(a)
  b = abs(bar)
  while b != 0:
    t = b
    b = a % b
    a = t
  return a

def lcm(a: int, b: int):
  return 0 if a == 0 or b == 0 else abs((a * b) / gcd(a, b))
