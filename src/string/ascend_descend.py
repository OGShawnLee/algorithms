def ascend_descend(length: int, min: int, max: int):
  if length <= 0 or min > max: return ""
  if min == max: 
    return str(min) * length if min > 0 else (str(min) * length)[:length]
  num = min
  num_str = str(num)
  string = ""
  is_going_up = min < max
  index = 0
  while len(string) < length:
    if is_going_up:
      num += 1
      if num == max: is_going_up = False
    else:
      num += -1
      if num == min: is_going_up = True
    string += num_str
    num_str = str(num)
    index += 1
  return string