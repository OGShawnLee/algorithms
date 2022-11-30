from pathlib import Path
from re import findall, search

def create_matrix(size: int):
  return [
    [-1 for _ in range(0, size)]
    for _ in range(0, size)
  ]

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def get_lit_lights_count(file_path: str, matrix_size: int):
  matrix = create_matrix(matrix_size)
  count = 0
  lines = get_file_lines(file_path)
  for line in lines:
    count += get_instruction_light_count_change(line, matrix)
  return count

def get_instruction_light_count_change(line: str, matrix: list[list[int]]):
  instruction, start, end = parse_line(line)
  change = 0
  if instruction == "toggle":
    change += use_instruction_light_count_change(start, end, lambda r_idx, c_idx: on_toggle(matrix, r_idx, c_idx))
  elif instruction == "turn on":
    change += use_instruction_light_count_change(start, end, lambda r_idx, c_idx: on_turn_on(matrix, r_idx, c_idx))
  elif instruction == "turn off":
    change += use_instruction_light_count_change(start, end, lambda r_idx, c_idx: on_turn_off(matrix, r_idx, c_idx))
  else:
    raise ValueError(f"Invalid Instruction: {instruction}")
  return change

def on_toggle(matrix: list[list[int]], row_index: int, column_index: int):
  light_state = matrix[row_index][column_index]
  matrix[row_index][column_index] = 1 if light_state == -1 else -1 
  return matrix[row_index][column_index]
  
def on_turn_on(matrix: list[list[int]], row_index: int, column_index: int):
  light_state = matrix[row_index][column_index]
  if light_state == 1:
    return 0
  matrix[row_index][column_index] = 1  
  return matrix[row_index][column_index]
  
def on_turn_off(matrix: list[list[int]], row_index: int, column_index: int):
  light_state = matrix[row_index][column_index]
  if light_state == -1:
    return 0
  matrix[row_index][column_index] = -1  
  return matrix[row_index][column_index]

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

def use_instruction_light_count_change(start: list[int], end: list[int], fn):
  change = 0
  for row_index in range(start[0], end[0] + 1):
    for column_index in range(start[1], end[1] + 1):
      change += fn(row_index, column_index)
  return change

INPUT_FILE_NAME = "./input.txt"
MATRIX_SIZE = 1000

if __name__ == "__main__":
  count = get_lit_lights_count(INPUT_FILE_NAME, MATRIX_SIZE)
  print(f"Lit Lights Count: {count}")
