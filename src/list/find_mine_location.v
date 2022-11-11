module list

pub fn find_mine_location(minefield [][]int) []int {
  for index, row in minefield {
    for tile in row {
      if tile == 1 { return [index, tile] }
    }
  }
  panic("Field does not contain a bomb! (Lucky!)")
}
