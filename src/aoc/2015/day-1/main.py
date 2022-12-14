from pathlib import Path

def get_basement_direction_position(lines: list[str]):
  floor_number = 0
  for line in lines:
    for index, ltr in enumerate(line):
      floor_number += get_direction_char_value(ltr)
      if floor_number == -1:
        return index + 1
  raise ValueError("Unable to Find Basement Direction Position")

def get_direction_char_value(char: str):
  if char == "(":
    return 1
  elif char == ")":
    return -1
  return 0

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def get_floor_number_from_directions(lines: str):
  floor_number = 0
  for line in lines:
    for ltr in line:
      floor_number += get_direction_char_value(ltr)
  return floor_number

INPUT_FILE_PATH = "./input.txt"

if __name__ == "__main__":
  directions = get_file_lines(INPUT_FILE_PATH)
  floor_number = get_floor_number_from_directions(directions)
  position = get_basement_direction_position(directions)
  print(f"Floor Number: {floor_number} | Basement Direction Position: {position}")
  