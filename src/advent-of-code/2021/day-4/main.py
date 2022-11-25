from pathlib import Path

INPUT_FILE_PATH = "./input.txt"
EXAMPLE_FILE_PATH = "./example.txt"

class Tile:
  def __init__(self, value: str):
    self.value = int(value)
    self.is_crossed = False

  def cross(self):
    self.is_crossed = True
  
  def handle_tile(self, row_index: int, tile_index: int, row_counters: list[int], column_counters: list[int]):
    self.cross()
    column_counters[tile_index] += 1
    row_counters[row_index] += 1
    if column_counters[tile_index] == 5 and row_counters[row_index] == 5:
      return True, "Cross!"
    if column_counters[tile_index] == 5:
      return True, "Column"
    if row_counters[row_index] == 5:
      return True, "Row"
    return False, "None"

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def get_rounds_and_board(lines: list[str]):
  rounds = [int(char) for char in lines[0].split(",")]
  boards: list[list[list[Tile]]] = []
  is_collecting_board = False
  for index in range(1, len(lines)):
    line = lines[index]
    if is_collecting_board:
      board = boards[-1]
      row = [Tile(char) for char in line.split()]
      board.append(row)
      if len(board) == 5:
        is_collecting_board = False
    if line == "":
      is_collecting_board = True
      boards.append([])
  return rounds, boards

def create_board_counters(length: int):
  columns: dict[int, list[int]] = {}
  for index in range(0, length):
    columns[index] = [0 for i in range(0, 5)]
  return columns

def get_last_winner_board(file_path: str):
  lines = get_file_lines(file_path)
  rounds, boards = get_rounds_and_board(lines)
  columns = create_board_counters(len(boards))
  rows = create_board_counters(len(boards))
  completed_boards: dict[int, tuple[int, str]] = {}
  last_board_index = len(boards) - 1
  for number in rounds:
    for index, board in enumerate(boards):
      is_board_completed = index in completed_boards
      if is_board_completed: continue 
      column_counters = columns[index]
      row_counters = rows[index]
      for row_index, row in enumerate(board):
        if is_board_completed: break
        for tile_index, tile in enumerate(row): # column
          if tile.value == number:
            is_already_crossed = tile.is_crossed
            if is_already_crossed: continue
            has_won, w_line = tile.handle_tile(row_index, tile_index, row_counters, column_counters)
            if has_won:
              last_board_index = index
              is_board_completed = True 
              completed_boards[index] = tile.value, w_line
              break
  if last_board_index in completed_boards:
    return boards[last_board_index], *completed_boards[last_board_index]
  raise ValueError("Unable to Find Last Winner Board")

def get_first_winner_board(file_path: str):
  lines = get_file_lines(file_path)
  rounds, boards = get_rounds_and_board(lines)
  columns = create_board_counters(len(boards))
  rows = create_board_counters(len(boards))
  # bold of you to assume i would make this performant first try
  for number in rounds:
    for index, board in enumerate(boards):
      column_counters = columns[index]
      row_counters = rows[index]
      for row_index, row in enumerate(board):
        for tile_index, tile in enumerate(row): # column
          if tile.value == number:
            is_already_crossed = tile.is_crossed
            if is_already_crossed: continue
            has_won, w_line = tile.handle_tile(row_index, tile_index, column_counters, row_counters)
            if has_won:
              return board, tile.value, w_line
  raise ValueError("Unable to Find Winner Board")

def get_winner_board_score(file_path: str, fn = get_first_winner_board):
  w_board, w_number, w_line = fn(file_path)
  uncrossed_count = 0
  for row in w_board:
    for tile in row:
      if not tile.is_crossed:
        uncrossed_count += tile.value
  score = uncrossed_count * w_number
  return score, w_number, w_line

if __name__ == "__main__":
  score, w_number, w_line = get_winner_board_score(EXAMPLE_FILE_PATH)
  print("First Board Winner:")
  print(" -- Results from Example File:")
  print(f" ---- Winner Board Score: {score} | Winner Number: {w_number} | Won in: {w_line}")
  score, w_number, w_line = get_winner_board_score(INPUT_FILE_PATH)
  print(" -- Results from Input File:")
  print(f" ---- Winner Board Score: {score} | Winner Number: {w_number} | Won in: {w_line}")
  score, w_number, w_line = get_winner_board_score(EXAMPLE_FILE_PATH, get_last_winner_board)
  print("Last Board Winner:")
  print(" -- Results from Example File:")
  print(f" ---- Last Winner Board Score: {score} | Winner Number: {w_number} | Won in: {w_line}")
  score, w_number, w_line = get_winner_board_score(INPUT_FILE_PATH, get_last_winner_board)
  print(" -- Results from Input File:")
  print(f" ---- Last Winner Board Score: {score} | Winner Number: {w_number} | Won in: {w_line}")
