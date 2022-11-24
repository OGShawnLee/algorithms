from pathlib import Path

EXAMPLE_FILE_PATH = "./example.txt"
INPUT_FILE_PATH = "./input.txt"

def create_matrix(size: int):
  return [[0 for i in range(0, size)] for index in range(0, size)]

def get_diagonal_coordinates(start: tuple[int, int], end: tuple[int, int]):
  minimum_x, maximum_x = minmax(start[0], end[0])
  minimum_y, maximum_y = minmax(start[1], end[1])
  is_x_ascending = start[0] < end[0]
  is_y_ascending = start[1] < end[1]
  coordinates_len = maximum_x + 1 - minimum_x
  coordinates: list[list[int]] = [
    [0, 0] for i in range(coordinates_len)
  ]
  for coordinate in coordinates:
    # i have to do this checks on every iteration cos python :/
    if is_x_ascending:
      coordinate[0] = minimum_x
      minimum_x += 1
    else:
      coordinate[0] = maximum_x
      maximum_x -= 1
    if is_y_ascending:
      coordinate[1] = minimum_y
      minimum_y += 1
    else:
      coordinate[1] = maximum_y
      maximum_y -= 1
  return coordinates

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def get_line_coordinates(lines: list[str]):
  coordinates: list[list[tuple[int, int]]] = []
  for line in lines:
    pairs_str = line.split(" -> ")
    coordinates_group = []
    coordinates.append(coordinates_group)
    for pair in pairs_str:
      coordinates_group.append([int(char) for char in pair.split(",")])
  return coordinates

def get_overlapped_count(file_path: str, matrix: list[list[int]]):
  lines = get_file_lines(file_path)
  coordinates = get_line_coordinates(lines)
  overlapped_count = 0
  for pair in coordinates:
    start, end = pair
    if is_horizontal_line(start, end):
      row = matrix[start[1]]
      tail = min(start[0], end[0])
      head = max(start[0], end[0])
      for column_index in range(tail, head + 1):
        row[column_index] += 1
        tile = row[column_index]
        if tile == 2:
          overlapped_count += 1
    elif is_vertical_line(start, end):
      column_index = start[0]
      tail = min(start[1], end[1])
      head = max(start[1], end[1])
      for row_index in range(tail, head + 1):
        matrix[row_index][column_index] += 1
        tile = matrix[row_index][column_index]
        if tile == 2:
          overlapped_count += 1
    else:
      diagonal_coordinates = get_diagonal_coordinates(start, end)
      for column_index, row_index in diagonal_coordinates:
        matrix[row_index][column_index] += 1
        tile = matrix[row_index][column_index]
        if tile == 2: 
          overlapped_count += 1
  return overlapped_count

def is_horizontal_line(start: tuple[int, int], end: tuple[int, int]):
  return start[1] == end[1]

def is_vertical_line(start: tuple[int, int], end: tuple[int, int]):
  return start[0] == end[0]

def minmax(a: int, b: int):
  return min(a, b), max(a, b)

def print_matrix(matrix: list[list[int]]):
  if len(matrix) < 20:
    for row in matrix:
      print('\t'.join(map(str, row)))

if __name__ == "__main__":
  # EXAMPLE FILE
  matrix = create_matrix(10)
  overlapped_count = get_overlapped_count(EXAMPLE_FILE_PATH, matrix)
  print("---------- Results from Example File ----------")
  print_matrix(matrix)
  print(f"--> Overlapped Count: {overlapped_count}\n")
  # INPUT FILE
  matrix = create_matrix(1000)
  overlapped_count = get_overlapped_count(INPUT_FILE_PATH, matrix)
  print("---------- Results from Input File ----------")
  print_matrix(matrix)
  print(f"--> Overlapped Count: {overlapped_count}\n")
