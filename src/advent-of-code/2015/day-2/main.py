from pathlib import Path

def calculate_present_wrapping_paper(line: str):
  length, width, heigth = parse_present_dimensions(line)
  small_side_area = length * width
  return (2 * length * width) + (2 * width * heigth) + (2 * heigth * length) + small_side_area

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def parse_present_dimensions(line: str):
  lenght, width, height = sorted([int(char) for char in line.split("x")])
  return lenght, width, height

def get_total_wrapping_paper(lines: list[str]):
  count = 0
  for line in lines:
    count += calculate_present_wrapping_paper(line)
  return count

INPUT_FILE_PATH = "./input.txt"

if __name__ == "__main__":
  directions = get_file_lines(INPUT_FILE_PATH)
  count = get_total_wrapping_paper(directions)
  print(f"Total Wrapping Paper: {count} square feet")
  