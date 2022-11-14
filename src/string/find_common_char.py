def find_common_char(string: str):
  common_char = string[0]
  common_char_count = string.count(common_char)
  cache = { "common": dict(char = common_char, count = common_char_count) } 
  cache[common_char] = common_char_count
  for char in string:
    if char in cache: continue
    char_count = string.count(char)
    cache[char] = char_count
    if char_count > cache["common"]["count"]:
      cache["common"]["char"] = char
      cache["common"]["count"] = char_count
  return cache["common"]
