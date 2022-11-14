def move_zeros_to_the_end(input: list[int]):
  for index, external in enumerate(input):
    if external != 0: continue
    for i in range(index + 1, len(input)):
      internal = input[i]
      if internal == 0: continue
      input[i] = 0
      input[index] = internal
      break
  return input


