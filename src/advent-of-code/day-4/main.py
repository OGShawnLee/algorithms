from pathlib import Path

INPUT_FILE_PATH = "./input.txt"
EXAMPLE_FILE_PATH = "./example.txt"

class Tile:
  def __init__(self, value: str):
    self.value = int(value)
    self.is_crossed = False

  def cross(self):
    self.is_crossed = True

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

def get_winner_board(file_path: str):
  lines = get_file_lines(file_path)
  rounds, boards = get_rounds_and_board(lines)
  columns = create_board_counters(len(boards))
  rows = create_board_counters(len(boards))
  # bold of you to assume i would make this performant first try
  for number in rounds:
    for index, board in enumerate(boards):
      board_columns = columns[index]
      board_rows = rows[index]
      for idx, row in enumerate(board):
        for i, tile in enumerate(row): # column
          if tile.value == number:
            is_already_crossed = tile.is_crossed
            if is_already_crossed: continue
            tile.cross()
            board_columns[i] += 1
            board_rows[idx] += 1
            if board_columns[i] == 5:
              return board, tile.value, "Column"
            if board_columns[i] == 5 and board_rows[idx] == 5:
              return board, tile.value, "Cross!"
            if board_rows[idx] == 5:
              return board, tile.value, "Row"
  raise ValueError("Unable to Find Winner Board")

def get_winner_board_score(file_path: str):
  w_board, w_number, w_line = get_winner_board(file_path)
  uncrossed_count = 0
  for row in w_board:
    for tile in row:
      if not tile.is_crossed:
        uncrossed_count += tile.value
  score = uncrossed_count * w_number
  return score, w_number, w_line

if __name__ == "__main__":
  score, w_number, w_line = get_winner_board_score(EXAMPLE_FILE_PATH)
  print("Results from Example File:")
  print(f"Winner Board Score: {score} | Winner Number: {w_number} | Won in: {w_line}")
  score, w_number, w_line = get_winner_board_score(INPUT_FILE_PATH)
  print("Results from Input File:")
  print(f"Winner Board Score: {score} | Winner Number: {w_number} | Won in: {w_line}")
