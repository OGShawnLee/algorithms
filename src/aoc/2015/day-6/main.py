from pathlib import Path
from re import findall, search
from typing import Callable

def create_matrix(size: int, value: int):
  return [
    [value for _ in range(0, size)]
    for _ in range(0, size)
  ]

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def get_brightness_light_count(file_path: str, matrix_size: int):
  lines = get_file_lines(file_path)
  matrix = create_matrix(matrix_size, 0)
  count = 0
  for line in lines:
    count += get_instruction_brightness_count(line, matrix)
  return count

def get_lit_lights_count(file_path: str, matrix_size: int):
  matrix = create_matrix(matrix_size, -1)
  count = 0
  lines = get_file_lines(file_path)
  for line in lines:
    count += get_instruction_light_count_change(line, matrix)
  return count

def get_instruction_light_count_change(line: str, matrix: list[list[int]]):
  return use_instruction_matching(line, matrix, on_toggle, on_turn_on, on_turn_off)

def get_instruction_brightness_count(line: str, matrix: list[list[int]]):
  return use_instruction_matching(
    line=line,
    matrix=matrix,
    on_toggle=on_toggle_brightness,
    on_turn_on=on_turn_on_brightness,
    on_turn_off=on_turn_off_brightness
  )

def on_toggle(matrix: list[list[int]], row_index: int, column_index: int):
  light_state = matrix[row_index][column_index]
  matrix[row_index][column_index] = 1 if light_state == -1 else -1 
  return matrix[row_index][column_index]

def on_toggle_brightness(matrix: list[list[int]], row_index: int, column_index: int):
  matrix[row_index][column_index] += 2
  return 2

def on_turn_on(matrix: list[list[int]], row_index: int, column_index: int):
  light_state = matrix[row_index][column_index]
  if light_state == 1:
    return 0
  matrix[row_index][column_index] = 1  
  return matrix[row_index][column_index]

def on_turn_on_brightness(matrix: list[list[int]], row_index: int, column_index: int):
  matrix[row_index][column_index] += 1  
  return 1

def on_turn_off(matrix: list[list[int]], row_index: int, column_index: int):
  light_state = matrix[row_index][column_index]
  if light_state == -1:
    return 0
  matrix[row_index][column_index] = -1  
  return matrix[row_index][column_index]

def on_turn_off_brightness(matrix: list[list[int]], row_index: int, column_index: int):
  brightness = matrix[row_index][column_index]
  if brightness == 0:
    return 0
  matrix[row_index][column_index] -= 1
  return -1  

def parse_line(line: str):
  instruction_match = search("(\w+ (off|on))|(\w+)", line)
  if not instruction_match: 
    raise ValueError("Unable to Parse Instruction")
  coordinates_matches = findall("(\d+),(\d+)", line)
  if len(coordinates_matches) == 0:
    raise ValueError("Unable to Parse Instruction Coordinates")
  instruction = instruction_match.group()
  start, end = [
    [int(match) for match in matches]
    for matches in coordinates_matches
  ]
  return instruction, start, end

def use_instruction_light_count_change(
  start: list[int], 
  end: list[int], 
  matrix: list[list[int]], 
  fn: Callable[[list[list[int]], int, int], int]
):
  change = 0
  for row_index in range(start[0], end[0] + 1):
    for column_index in range(start[1], end[1] + 1):
      change += fn(matrix, row_index, column_index)
  return change

def use_instruction_matching(
  line: str, 
  matrix: list[list[int]], 
  on_toggle: Callable[[list[list[int]], int, int], int], 
  on_turn_on: Callable[[list[list[int]], int, int], int], 
  on_turn_off: Callable[[list[list[int]], int, int], int]
):
  instruction, start, end = parse_line(line)
  change = 0
  if instruction == "toggle":
    change += use_instruction_light_count_change(start, end, matrix, on_toggle)
  elif instruction == "turn on":
    change += use_instruction_light_count_change(start, end, matrix, on_turn_on)
  elif instruction == "turn off":
    change += use_instruction_light_count_change(start, end, matrix, on_turn_off)
  else:
    raise ValueError(f"Invalid Instruction: {instruction}")
  return change

INPUT_FILE_NAME = "./input.txt"
MATRIX_SIZE = 1000

if __name__ == "__main__":
  count = get_lit_lights_count(INPUT_FILE_NAME, MATRIX_SIZE)
  print(f"Lit Lights Count: {count}")
  brightness = get_brightness_light_count(INPUT_FILE_NAME, MATRIX_SIZE)
  print(f"Light Brightness: {brightness}")
