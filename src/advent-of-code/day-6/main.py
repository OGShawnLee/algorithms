from pathlib import Path

class Lanternfish:
  def __init__(self, count: int, is_newborn = False):
    self.count = count
    self.is_newborn = is_newborn

def get_lanternfish(file_path: str):
  lines = get_file_lines(file_path)
  return [ 
    Lanternfish(int(count_str)) 
    for line in lines 
    for count_str in line.split(",") 
  ]

def get_lanternfish_population(school: list[Lanternfish], day_limit: int):
  day = 0
  while day < day_limit:
    day += 1
    for lanternfish in school:
      if lanternfish.is_newborn:
        lanternfish.is_newborn = False
        continue
      if lanternfish.count == 0:
        lanternfish.count = 6
        school.append(Lanternfish(8, True))
      elif lanternfish.count <= 8:
        lanternfish.count -= 1
  return len(school)

def get_file_lines(file_path: str):
  file = Path(__file__).with_name(file_path)
  return file.read_text().splitlines()

EXAMPLE_FILE_PATH = "./example.txt"
INPUT_FILE_PATH = "./input.txt"
DAY_LIMIT = 80

if __name__ == "__main__":
  school = get_lanternfish(EXAMPLE_FILE_PATH)
  population = get_lanternfish_population(school, DAY_LIMIT)
  print("Example File Results:")
  print(f"lanternfish population: {population}")
  
  school = get_lanternfish(INPUT_FILE_PATH)
  population = get_lanternfish_population(school, DAY_LIMIT)
  print("Input File Results:")
  print(f"lanternfish population: {population}")