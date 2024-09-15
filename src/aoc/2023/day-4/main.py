from pathlib import Path

def each_line(file_path):
  file = Path(__file__).with_name(file_path)
  with file.open("r") as lines:
    for line in lines:
      yield line

def get_scratchcards_sum(file_path):
  sum = 0

  for line in each_line(file_path):
    match_count = 0
    start = line.index(":") + 1

    winning_numbers_slice, current_numbers_slice = line[start:].split("|")
    winning_numbers = [int(number) for number in winning_numbers_slice.split()]
    current_numbers = [int(number) for number in current_numbers_slice.split()] 
    
    for current_number in current_numbers:
      if current_number in winning_numbers:
        match_count += 1

    if match_count > 0:
      sum += 2 ** (match_count - 1)

  return sum

scratchcards_sum_example = get_scratchcards_sum("example.txt")
scratchcards_sum = get_scratchcards_sum("input.txt")

print("Scractchcards Sum Example:", scratchcards_sum_example)
print("Scractchcards Sum:", scratchcards_sum)
