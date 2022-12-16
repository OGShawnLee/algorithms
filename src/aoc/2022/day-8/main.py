from pathlib import Path

def create_matrix(size: int):
  return [
    [0 for i in range(size)] 
    for index in range(size)
  ]

def create_tree_grid(lines: list[str], size: int):
  grid = create_matrix(size)
  for row_index, line in enumerate(lines):
    for column_index, char in enumerate(line):
      grid[row_index][column_index] = int(char)
  return grid

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def get_visible_tree_count(lines: list[str], size: int):
  count = 0
  grid = create_tree_grid(lines, size)
  for row_index, row in enumerate(grid):
    for column_index, tree_height in enumerate(row):
      if is_visible(grid, row_index, column_index, tree_height):
        count += 1
  return count

def is_in_edge(grid: list[list[int]], r_idx: int, c_idx: int):
  last_element_index = len(grid) - 1
  return (
    r_idx == 0 or r_idx == last_element_index or
    c_idx == 0 or c_idx == last_element_index
  )

def is_visible(grid: list[list[int]], row_index: int, column_index: int, tree_height: int):
  return (
    is_in_edge(grid, row_index, column_index) or
    is_visible_from(grid, row_index, column_index, tree_height, "top") or 
    is_visible_from(grid, row_index, column_index, tree_height, "right") or
    is_visible_from(grid, row_index, column_index, tree_height, "bottom") or
    is_visible_from(grid, row_index, column_index, tree_height, "left")  
  )

def is_visible_from(grid: list[list[int]], r_idx: int, c_idx: int, tree_height: int, direction: str):
  length = len(grid)
  if direction == "top":
    for row_index in range(r_idx - 1, -1, -1):
      height = grid[row_index][c_idx]
      if height >= tree_height:
        return False 
  elif direction == "right":
    for column_index in range(c_idx + 1, length):
      height = grid[r_idx][column_index]
      if height >= tree_height:
        return False
  elif direction == "bottom":
    for row_index in range(r_idx + 1, length):
      height = grid[row_index][c_idx]
      if height >= tree_height:
        return False
  elif direction == "left":
    for column_index in range(c_idx - 1, -1, -1):
      height = grid[r_idx][column_index]
      if height >= tree_height:
        return False
  else:
    raise ValueError(f"{direction} is an invalid direction")
  return True

def print_results(file_name: str, count: int):
  print(f"{file_name} File:")
  print(f"Visible Trees Count: {count}")

FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"
GRID_SIZE_EXAMPLE = 5
GRID_SIZE_INPUT = 99

lines = get_file_lines(FILE_PATH_EXAMPLE)
count = get_visible_tree_count(lines, GRID_SIZE_EXAMPLE)
print_results("Example", count)

lines = get_file_lines(FILE_PATH_INPUT)
count = get_visible_tree_count(lines, GRID_SIZE_INPUT)
print_results("Example", count)
