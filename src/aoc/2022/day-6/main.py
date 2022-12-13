from pathlib import Path

def find_marker_start_position(line: str):
  package: list[str] = []
  for index, char in enumerate(line):
    if char in package:
      repeated_index = package.index(char)
      package = package[repeated_index + 1:]
    if len(package) == 4:
      return index, package
    package.append(char)
  return -1, package

def get_file_lines(file_path: str):
  file = Path(__name__).with_name(file_path)
  return file.read_text().splitlines()

def print_results(lines: list[str]):
	for index, line in enumerate(lines):
		position, package = find_marker_start_position(line)
		if position == -1:
			print(f'Unable to find Start Position and Package from line {index}')
		else:
			print(f'Start Position: {position} | Package: {package}')

FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"

if __name__ == "__main__":
  lines = get_file_lines(FILE_PATH_EXAMPLE)
  print_results(lines)
  lines = get_file_lines(FILE_PATH_INPUT)
  print_results(lines)
