from pathlib import Path

# 1. Read the input file line by line
# 2. Process each character
# 2.1 Store continuous digits instances
# 2.2 Store individual symbols that are not a dot
# 3. For each symbol, check if there is a number above, below, next to it or diagonal to it

class Symbol:
  data: str
  row: int
  col: int

  def __init__(self, data: str, row: int, col: int):
    self.data = data
    self.row = row
    self.col = col

  def print(self):
    print(f"Symbol: {self.data} at ({self.row}, {self.col})")

class Number:
  number_str: str
  row: int
  col_begin: int
  col_end: int

  def __init__(self, row: int, begin: int, number_str):
    self.row = row
    self.col_begin = self.col_end = begin
    self.number_str = number_str

  def get_number(self):
    return int(self.number_str)

  def is_in_range(self, digit: int):
    return digit >= self.col_begin and digit <= self.col_end

  def print(self):
    print(f"Number: {self.number_str} at ({self.row}, {self.col_begin} - {self.col_end})")

def each_line(file_path):
  file = Path(__file__).with_name(file_path)
  with file.open("r") as lines:
    for line in lines:
      yield line

# 1 - 2
# States: iddle | digit-accumulation, 

numbers: dict[int, list[Number]] = {}
symbols: list[Symbol] = []

for row, line in enumerate(each_line("input.txt")):
  number = None
  row_list = []
  state = "idle"

  for column, character in enumerate(line):
    if state == "idle":
      # Start of a number
      if character.isdigit():
        state = "digit-accumulation"
        # Create a new number and a list of numbers for the current row
        number = Number(row, column, character)
        row_list.append(number)
        numbers[row] = row_list
      else:
        state = "idle"
        # Store the symbol
        if character != "." and not character.isspace():
          symbols.append(Symbol(character, row, column))
    elif state == "digit-accumulation":
      if character.isdigit():
        # Continue accumulating the number and updating its ending column
        number.number_str += character
        number.col_end = int(column)
      # End of a number
      else:
        state = "idle"
        # Store the symbol
        if character != "." and not character.isspace():
          symbols.append(Symbol(character, row, column))
    else:
      raise Exception("Invalid state")

# 3 

count = 0

for symbol in symbols:
  line_index_above = symbol.row - 1
  line_index_below = symbol.row + 1
  col_index_left = symbol.col - 1
  col_index_right = symbol.col + 1

  # Line Above
  if line_index_above in numbers:
    for number in numbers[line_index_above]:
      # Check right above
      if number.is_in_range(symbol.col):
        count += number.get_number()
        number.print()
        symbol.print()
        print("")
      # Check above to the left or right (diagonal)
      elif number.col_end == col_index_left or number.col_begin == col_index_right:
        count += number.get_number()        
        number.print()
        symbol.print()
        print("")

  # Same Line
  if symbol.row in numbers:
    # Next to the number (left or right)
    for number in numbers[symbol.row]:
      if number.col_end == col_index_left or number.col_begin == col_index_right:
        count += number.get_number()
        number.print()
        symbol.print()
        print("")

  # Line Below
  if line_index_below in numbers:
    for number in numbers[line_index_below]:
      # Check right below
      if number.is_in_range(symbol.col):
        count += number.get_number()
        number.print()
        symbol.print()
        print("")
      # Check below to the left or right (diagonal)
      elif number.col_end == col_index_left or number.col_begin == col_index_right:
        count += number.get_number()
        number.print()
        symbol.print()
        print("")

print("Count:", count)
