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

if __name__ == "__main__":
  increased_count = get_depth_increased_amount(file_name) 
  print(f"times a depth measurement increased from the previous one: {increased_count}")