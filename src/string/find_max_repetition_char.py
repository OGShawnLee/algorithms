def find_max_repetition_char(string: str):
  if len(string) == 0: return "", 0
  maximum = dict(char = string[0], count = 1)
  current = dict(char = string[0], count = 1)
  for index in range(1, len(string)):
    char = string[index]
    if char == current['char']:
      current["count"] += 1
    else:
      current['char'] = char
      current['count'] = 1
    if current['count'] > maximum["count"]:
      maximum['char'] = current["char"]
      maximum['count'] = current['count']
  return maximum['char'], maximum['count']
