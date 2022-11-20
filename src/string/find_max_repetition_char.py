def find_max_repetition_char(string: str):
  max_char = ""; max_count = 0
  char = max_char; count = max_count
  for letter in string:
    if letter == char:
      count += 1
    else:
      char = letter
      count = 1
    if count > max_count:
      max_char = char; max_count = count
  return max_char, max_count
