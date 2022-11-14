from pathlib import Path

file = Path(__file__).with_name("input.txt")
increased_count = 0
with file.open("r") as lines:
  previous_depth = int(lines.readline())
  for depth in lines:
    depth = int(depth)
    if depth > previous_depth:
        increased_count += 1
    previous_depth = depth

print(f"times a depth measurement increased from the previous one: {increased_count}")
