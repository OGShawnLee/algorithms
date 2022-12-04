from pathlib import Path

file_name = "input.txt"

def get_depth_increased_amount(file_name: str):
  file = Path(__file__).with_name(file_name)
  increased_count = 0
  with file.open("r") as lines:
    previous_depth = int(lines.readline())
    for depth in lines:
      depth = int(depth)
      if depth > previous_depth:
          increased_count += 1
      previous_depth = depth
  return increased_count

def get_depth_sliding_window_increased_amount(file_path: str, window_length: int, encoding: str):
  lines = get_file_lines(file_path, encoding)
  increased_count = 0
  previous_sum = 0
  current_sum = 0
  for index, line in enumerate(lines):
    current_sum += int(line)
    if index >= window_length:
      current_sum -= int(lines[index - window_length])
      if current_sum > previous_sum:
        increased_count += 1
      previous_sum = current_sum
  return increased_count

def get_file_lines(file_path: str, encoding: str):
  file = Path(__file__).with_name(file_path)
  text = file.read_text(encoding)
  return text.splitlines()

if __name__ == "__main__":
  increased_count = get_depth_increased_amount(file_name) 
  print(f"times a depth measurement increased from the previous one: {increased_count}")
  window_increased_count = get_depth_sliding_window_increased_amount(file_name, 3, "utf-8")
  print(f"3-sliding-window depth measurement increased count: {window_increased_count}")