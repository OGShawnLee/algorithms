def create_matrix size
  Array.new(size) { Array.new(size) }
end 

def create_tree_grid lines, size
  grid = create_matrix(size)
  lines.each.with_index do |line, row_index|
    line.each_char.with_index do |char, column_index|
      grid[row_index][column_index] = char.to_i
    end
  end
  return grid
end

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_max_tree_scenic_score lines, size
  max = 0
  grid = create_tree_grid(lines, size)
  grid.each.with_index do |row, row_index|
    row.each.with_index do |tree_height, column_index|
      scenic_score = get_tree_scenic_score(grid, row_index, column_index, tree_height)
      max = scenic_score if scenic_score > max
    end
  end
  return max
end


def get_tree_scenic_score grid, row_index, column_index, tree_height
  scores = DIRECTIONS.map do |direction|
    count = 0
    use_direction_loop(grid, row_index, column_index, tree_height, direction, count) do |height|
      count += 1
      if tree_height <= height
        true 
      end
    end
    count
  end
  return scores.reduce(:*)
end
  
def get_visible_tree_count lines, size
  count = 0
  grid = create_tree_grid(lines, size)
  grid.each.with_index do |row, row_index|
    row.each.with_index do |tree_height, column_index|
      count += 1 if is_visible(grid, row_index, column_index, tree_height)
    end
  end
  return count
end

def is_in_edge grid, row_index, column_index
  last_element_index = grid.length - 1
  in_row_edge = row_index == 0 || row_index == last_element_index || 
  in_column_edge = column_index == 0 || column_index == last_element_index
  return in_row_edge || in_column_edge
end

def is_visible grid, row_index, column_index, tree_height
  is_in_edge(grid, row_index, column_index) ||
  is_visible_from(grid, row_index, column_index, tree_height, "top") ||
  is_visible_from(grid, row_index, column_index, tree_height, "right") ||
  is_visible_from(grid, row_index, column_index, tree_height, "bottom") ||
  is_visible_from(grid, row_index, column_index, tree_height, "left")
end 

def is_visible_from grid, row_index, column_index, tree_height, direction
  use_direction_loop(grid, row_index, column_index, tree_height, direction, true) do |height|
    if height >= tree_height
      [true, false]
    end
  end 
end

def print_results file_name, count, scenic_score
  puts "#{file_name} File Results:"
  puts "Visible Trees Count: #{count}"
  puts "Maximum Tree Scenic Score: #{scenic_score}"
end

def use_direction_loop grid, row_index, column_index, tree_height, direction, initial_value
  len = grid.length
  case direction
  when "top"
    (row_index - 1).downto(0) do |r_idx|
      height = grid[r_idx][column_index]
      return_early, value = yield height
      return value if return_early
    end
  when "right"
    (column_index + 1).upto(len - 1) do |c_idx|
      height = grid[row_index][c_idx]
      return_early, value = yield height
      return value if return_early
    end
  when "bottom"
    (row_index + 1).upto(len - 1) do |r_idx|
      height = grid[r_idx][column_index]
      return_early, value = yield height
      return value if return_early
    end
  when "left"
    (column_index - 1).downto(0) do |c_idx|
      height = grid[row_index][c_idx]
      return_early, value = yield height
      return value if return_early
    end
  end
  return initial_value
end

DIRECTIONS = ["top", "right", "bottom", "left"]
FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"
GRID_SIZE_EXAMPLE = 5
GRID_SIZE_INPUT = 99

lines = get_file_lines(FILE_PATH_EXAMPLE)
count = get_visible_tree_count(lines, GRID_SIZE_EXAMPLE)
scenic_score = get_max_tree_scenic_score(lines, GRID_SIZE_EXAMPLE)
print_results("Example", count, scenic_score)

lines = get_file_lines(FILE_PATH_INPUT)
count = get_visible_tree_count(lines, GRID_SIZE_INPUT)
scenic_score = get_max_tree_scenic_score(lines, GRID_SIZE_INPUT)
print_results("Input", count, scenic_score)
