from pathlib import Path

FILE_PATH = "./input.txt"

class BitCounter:
  def __init__(self):
    self.on = 0
    self.off = 0

  def count(self, char: str):
    if char == "1":
      self.on += 1
    else:
      self.off += 1
  
  def get_common_char(self):
    return "1" if self.on >= self.off else "0"

  def get_uncommon_char(self):
    return "0" if self.on >= self.off else "1"

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

def get_gamma_and_episilon_rate(lines: list[str]):
  gamma_rate = "" 
  epsilon_rate = ""
  counts = [dict(on = 0, off = 0) for index in range(0, 12)]
  for line in lines:
    for index, char in enumerate(line):
      if char == "1":
        counts[index]["on"] += 1
      else:
        counts[index]["off"] += 1
  for count in counts:
    if count["on"] > count["off"]:
      gamma_rate += "1"
      epsilon_rate += "0"
    else:
      gamma_rate += "0"
      epsilon_rate += "1"
  return (gamma_rate, epsilon_rate)

def get_submarine_power_consumption(file_path: str):
  lines = get_file_lines(file_path)
  gamma_str, epsilon_str = get_gamma_and_episilon_rate(lines)
  gamma_str = int(gamma_str, 2)
  epsilon_str = int(epsilon_str, 2)
  return gamma_str * epsilon_str

def get_submarine_oxygen_support_rate(file_path: str):
  lines = get_file_lines(file_path)
  for index in range(0, 12):
    if len(lines) == 1: 
      break
    counter = BitCounter()
    for line in lines:
      counter.count(line[index])
    lines = [line for line in lines if line[index] == counter.get_common_char()]
  return int(lines[0], 2)

def get_submarine_carbon_ratings(file_path: str):
  lines = get_file_lines(file_path)
  for index in range(0, 12):
    if len(lines) == 1: 
      break
    counter = BitCounter()
    for line in lines:
      counter.count(line[index])
    lines = [line for line in lines if line[index] == counter.get_uncommon_char()]
  return int(lines[0], 2)

def get_submarine_life_support_ratings(file_path: str):
  oxygen = get_submarine_oxygen_support_rate(file_path)
  carbon = get_submarine_carbon_ratings(file_path)
  return oxygen * carbon

if __name__ == "__main__":
  power = get_submarine_power_consumption(FILE_PATH)
  print(f"submarine power consumption: {power}")
  life_support = get_submarine_life_support_ratings(FILE_PATH)
  print(f"life support rating: {life_support}")