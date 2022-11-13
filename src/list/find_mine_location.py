def find_mine_location(minefield: list[tuple[int, int]]) -> tuple[int, int]:
  for index, row in enumerate(minefield):
    for idx, tile in enumerate(row):
      if tile == 1:
        return [index, idx]
  raise ValueError("Field does not container a bomb! (Lucky!)")