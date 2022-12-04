import hashlib

SECRET_KEY = "iwrupvqb"

def find_coin(key: str):
  index = 0
  while True:
    string = key + str(index)
    hashed = hashlib.md5(string.encode())
    if is_correct_hash(hashed.hexdigest()):
      return hashed.hexdigest(), index 
    index += 1

def is_correct_hash(hashed: str):
  return hashed[0:5] == "00000"

if __name__ == "__main__":
  hashed, number = find_coin(SECRET_KEY) # 346386
  print(f"Correct Hash: {hashed} | Number: {number}")