vowels = { "a": "a", "e": "e", "i": "i", "o": "o", "u": "u" }

def get_vowel_count(string: str):
  string = string.lower()
  count = 0
  for char in string:
    if char in vowels: count += 1
  return count
  