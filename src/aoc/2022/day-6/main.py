from pathlib import Path

def find_marker_start_position(line: str, length: int):
  package: list[str] = []
  for index, char in enumerate(line):
    if len(package) == length:
      return index, package
    if char in package:
      repeated_index = package.index(char)
      package = package[repeated_index + 1:]
    package.append(char)
  return -1, package

def get_file_lines(file_path: str):
  file = Path(__name__).with_name(file_path)
  return file.read_text().splitlines()

def print_results(lines: list[str], length: int, type: str):
  print(f"- {type} Start Position:")
  for index, line in enumerate(lines):
    position, package = find_marker_start_position(line, length)
    if position == -1:
      print(f'-- Unable to find Start Position and Package from line {index}')
    else:
      print(f'-- Start Position: {position} | Package: {package}')

FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"
POSITION_LEN_MARKER = 4
POSITION_LEN_MESSAGE = 14

if __name__ == "__main__":
  lines = get_file_lines(FILE_PATH_EXAMPLE)
  print("Example File Results:")
  print_results(lines, POSITION_LEN_MARKER, "Marker")
  print_results(lines, POSITION_LEN_MESSAGE, "Message")
  lines = get_file_lines(FILE_PATH_INPUT)
  print("Input File Results:")
  print_results(lines, POSITION_LEN_MARKER, "Marker")
  print_results(lines, POSITION_LEN_MESSAGE, "Message")
