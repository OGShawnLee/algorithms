from pathlib import Path

# 1. Read the input file line by line
# 2. Process each character
# 2.1 Store continuous digits instances
# 2.2 Store individual symbols that are not a dot
# 3a For each symbol, check if there is a number above, below, next to it or diagonal to it
# 3b For each gear symbol, check if there are two numbers above, below, next to it or diagonal to it

class Symbol:
  data: str
  row: int
  col: int
  is_gear: bool

  def __init__(self, data: str, row: int, col: int):
    self.data = data
    self.row = row
    self.col = col
    self.is_gear = data == "*"

  def print(self):
    print(f"Symbol: {self.data} at ({self.row}, {self.col}) is gear: {self.is_gear}")

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

def get_numbers_and_symbols(file_path: str):
  numbers: dict[int, list[Number]] = {}
  symbols: list[Symbol] = []

  for row, line in enumerate(each_line(file_path)):
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

  return numbers, symbols

# 3 

def get_adjacent_sum(file_path: str):
  numbers, symbols = get_numbers_and_symbols(file_path)
  sum = 0

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
          sum += number.get_number()
          number.print()
          symbol.print()
          print("")
        # Check above to the left or right (diagonal)
        elif number.col_end == col_index_left or number.col_begin == col_index_right:
          sum += number.get_number()        
          number.print()
          symbol.print()
          print("")

    # Same Line
    if symbol.row in numbers:
      # Next to the number (left or right)
      for number in numbers[symbol.row]:
        if number.col_end == col_index_left or number.col_begin == col_index_right:
          sum += number.get_number()
          number.print()
          symbol.print()
          print("")

    # Line Below
    if line_index_below in numbers:
      for number in numbers[line_index_below]:
        # Check right below
        if number.is_in_range(symbol.col):
          sum += number.get_number()
          number.print()
          symbol.print()
          print("")
        # Check below to the left or right (diagonal)
        elif number.col_end == col_index_left or number.col_begin == col_index_right:
          sum += number.get_number()
          number.print()
          symbol.print()
          print("")

  return sum

def get_gear_ration_sum(file_path: str):
  numbers, symbols = get_numbers_and_symbols(file_path)
  sum = 0

  for symbol in symbols:
    if not symbol.is_gear:
      continue

    line_index_above = symbol.row - 1
    line_index_below = symbol.row + 1
    col_index_left = symbol.col - 1
    col_index_right = symbol.col + 1
    connections: list[int] = []

    # Line Above
    if line_index_above in numbers:
      for number in numbers[line_index_above]:
        # Check right above
        if number.is_in_range(symbol.col):
          connections.append(number.get_number())
        # Check above to the left or right (diagonal)
        if number.col_end == col_index_left or number.col_begin == col_index_right:
          connections.append(number.get_number())

    # Same Line
    if symbol.row in numbers:
      # Next to the number (left or right)
      for number in numbers[symbol.row]:
        if number.col_end == col_index_left or number.col_begin == col_index_right:
          connections.append(number.get_number())

    # Line Below
    if line_index_below in numbers:
      for number in numbers[line_index_below]:
        # Check right below
        if number.is_in_range(symbol.col):
          connections.append(number.get_number())
        # Check below to the left or right (diagonal)
        if number.col_end == col_index_left or number.col_begin == col_index_right:
          connections.append(number.get_number())

    if len(connections) >= 2:
      sum += connections[0] * connections[1]

  return sum

adjacent_sum = get_adjacent_sum("input.txt")
adjacent_sum_example = get_adjacent_sum("example.txt")
gear_ration_sum = get_gear_ration_sum("input.txt")
gear_ratio_sum_example = get_gear_ration_sum("example.txt")

print("Adjacent Sum:", adjacent_sum)
print("Adjacent Sum Example:", adjacent_sum_example)
print("Gear Ratio Sum:", gear_ration_sum)
print("Gear Ratio Sum Example:", gear_ratio_sum_example)
