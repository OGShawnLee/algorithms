from pathlib import Path
 
FILE_PATH = "./input.txt"

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

if __name__ == "__main__":
  power = get_submarine_power_consumption(FILE_PATH)
  print(f"submarine power consumption: {power}")
