from pathlib import Path

def get_file_lines(file_path: str):
  file = Path(__name__).with_name(file_path)
  return file.read_text().splitlines()
  
def get_contained_and_overlapped_count(lines: list[str]):
  contained = 0
  overlapped = 0
  for line in lines:
    a, b = parse_line_pair(line)
    is_contained = is_contained_in(a, b)
    is_overlapped = is_overlapped_in(a, b)
    if is_contained:
      contained += 1
    if is_overlapped:
      overlapped += 1
  return contained, overlapped

def is_contained_in(a: list[int], b: list[int]):
  a_in_b = a[0] >= b[0] and a[1] <= b[1]
  b_in_a = b[0] >= a[0] and b[1] <= a[1]
  return a_in_b or b_in_a

def is_overlapped_in(a: list[int], b: list[int]):
  return max(a[0], b[0]) <= min(a[1], b[1])

def parse_line_pair(line: str):
  return [
    [int(char) for char in pair.split("-")]
    for pair in line.split(",")
  ]

def print_results(file_name: str, contained: int, overlapped: int):
  print(f"{file_name} Results")
  print(f"Contained Count: {contained} | Overlapped: {overlapped}")

EXAMPLE_PATH = "./example.txt"
INPUT_PATH = "./input.txt"

if __name__ == "__main__":
  lines = get_file_lines(EXAMPLE_PATH)
  contained, overlapped = get_contained_and_overlapped_count(lines)
  print_results("Example", contained, overlapped)

  lines = get_file_lines(INPUT_PATH)
  contained, overlapped = get_contained_and_overlapped_count(lines)
  print_results("Input", contained, overlapped)
