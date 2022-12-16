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
  len = grid.length
  case direction
  when "top"
    (row_index - 1).downto(0) do |r_idx|
      height = grid[r_idx][column_index]
      return false if height >= tree_height 
    end
  when "right"
    (column_index + 1).upto(len - 1) do |c_idx|
      height = grid[row_index][c_idx]
      return false if height >= tree_height 
    end
  when "bottom"
    (row_index + 1).upto(len - 1) do |r_idx|
      height = grid[r_idx][column_index]
      return false if height >= tree_height
    end
  when "left"
    (column_index - 1).downto(0) do |c_idx|
      height = grid[row_index][c_idx]
      return false if height >= tree_height
    end
  end
  return true
end

def print_results file_name, count
  puts "#{file_name} File Results:"
  puts "Visible Trees Count: #{count}"
end

FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"
GRID_SIZE_EXAMPLE = 5
GRID_SIZE_INPUT = 99

lines = get_file_lines(FILE_PATH_EXAMPLE)
count = get_visible_tree_count(lines, GRID_SIZE_EXAMPLE)
print_results("Example", count)

lines = get_file_lines(FILE_PATH_INPUT)
count = get_visible_tree_count(lines, GRID_SIZE_INPUT)
print_results("Input", count)
