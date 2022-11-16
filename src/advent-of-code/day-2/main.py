from pathlib import Path

file_path = "./input.txt"

def get_file_lines(file_path: str, encoding: str):
  file = Path(__file__).with_name(file_path)
  text = file.read_text(encoding)
  return text.splitlines()

def get_submarine_position(file_path: str):
  lines = get_file_lines(file_path, "utf-8")
  forward = 0
  depth = 0
  for line in lines:
    direction, value = parse_line(line)
    # i still use python 3.9.2 so no match statement here :[
    if direction == "forward":
      forward += value
    elif direction == "up":
      depth -= value
    elif direction == "down":
      depth += value
    else:
      raise ValueError(f"{direction} is an invalid directin")
  return forward * depth

def parse_line(line: str):
  parsed = line.split(" ")
  direction = parsed[0]
  value = int(parsed[1])
  return (direction, value)

if __name__ == "__main__":
  position = get_submarine_position(file_path)
  print(f"submarine position: {position}")
