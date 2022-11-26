from pathlib import Path

def calculate_present_ribbon(length: int, width: int, height: int):
  ribbon = length * 2 + width * 2
  bow = length * width * height
  return ribbon + bow

def calculate_present_wrapping_paper(length: int, width: int, height: int):
  small_side_area = length * width
  return (2 * length * width) + (2 * width * height) + (2 * height * length) + small_side_area

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def parse_present_dimensions(line: str):
  lenght, width, height = sorted([int(char) for char in line.split("x")])
  return lenght, width, height

def get_total_wrapping_paper_and_ribbon(lines: list[str]):
  wrapping_paper = 0
  ribbon = 0
  for line in lines:
    length, width, height = parse_present_dimensions(line)
    wrapping_paper += calculate_present_wrapping_paper(length, width, height)
    ribbon += calculate_present_ribbon(length, width, height)
  return wrapping_paper, ribbon

INPUT_FILE_PATH = "./input.txt"

if __name__ == "__main__":
  directions = get_file_lines(INPUT_FILE_PATH)
  paper, ribbon = get_total_wrapping_paper_and_ribbon(directions)
  print(f"Total Wrapping Paper: {paper} square feet | Total Ribbon: {ribbon} feet")
  