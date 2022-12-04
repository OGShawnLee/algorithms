from pathlib import Path

COORDINATE_VALUES = { "^": 1, "v": -1, ">": 1, "<": -1 }
INPUT_FILE_PATH = "./input.txt"

def get_coordinate_key(x: int, y: int):
  return str(x) + str(y)

def get_visited_houses_count(lines: list[str]):
  visited_coordinates: dict[str, bool] = {}
  x = 0
  y = 0
  for line in lines:
    for char in line:
      key = get_coordinate_key(x, y)
      visited_coordinates[key] = True
      if is_horizontal_line(char):
        x += COORDINATE_VALUES[char]
      elif is_vertical_line(char):
        y += COORDINATE_VALUES[char]
  return len(visited_coordinates)

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def is_horizontal_line(code: str):
  return code == ">" or code == "<"

def is_vertical_line(code: str):
  return code == "^" or code == "v"

if __name__ == "__main__":
  lines = get_file_lines(INPUT_FILE_PATH)
  count = get_visited_houses_count(lines)
  print(f"Visited Houses: {count}")
