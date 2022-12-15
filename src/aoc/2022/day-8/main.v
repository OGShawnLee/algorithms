import os { read_lines }

const (
	file_path_example = "./example.txt"
	file_path_input = "./input.txt"
	grid_size_example = 5
	grid_size_input = 99
)

fn main() {
	mut lines := get_file_lines(file_path_example)!
	mut visible_count := get_visible_grid_trees(lines, grid_size_example)!
	print_results("Example", visible_count)

	lines = get_file_lines(file_path_input)!
	visible_count = get_visible_grid_trees(lines, grid_size_input)!
	print_results("Input", visible_count)
}

fn create_tree_grid(lines []string, size int) [][]int {
	mut grid := create_matrix(size)
	for row_index, line in lines {
		for column_index, code in line {
			grid[row_index][column_index] = code.ascii_str().int()
		}
	}
	return grid
}

fn create_matrix(size int) [][]int {
	return [][]int {
		cap: size,
		len: size,
		init: []int { cap: size, len: size }
	}
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or {
		panic("unable to read lines from file $file_path")
	}
	return lines
}

fn get_visible_grid_trees(lines []string, size int) !int {
	grid := create_tree_grid(lines, size)
	mut count := 0
	for r_idx, row in grid {
		for c_idx, tree_height in row {
			if is_visible(grid, r_idx, c_idx, tree_height)! {
				count++
			}
		}
	}
	return count
}

fn is_in_edge(grid [][]int, row_index int, column_index int) bool {
	len := grid.len
	is_in_column_edge := column_index == 0 || column_index == len - 1
	is_in_row_edge := row_index == 0 || row_index == len - 1
	return is_in_column_edge || is_in_row_edge
}

fn is_visible_from(
	grid [][]int, 
	row_index int, 
	column_index int, 
	tree_height int, 
	direction string
) !bool {
	mut is_visible := true
	match direction {
		"top" {
			for r_index := row_index - 1; r_index >= 0; r_index-- {
				top_tree := grid[r_index][column_index]
				if top_tree >= tree_height { is_visible = false }
			} 
		}
		"bot" {
			for r_index in row_index + 1..grid.len {
				bottom_tree := grid[r_index][column_index]
				if bottom_tree >= tree_height { is_visible = false }
			}
		}
		"right" {
			for c_index in column_index + 1..grid.len {
				right_tree := grid[row_index][c_index]
				if right_tree >= tree_height { is_visible = false }
			}
		}
		"left" {
			for c_index := column_index - 1; c_index >= 0; c_index-- {
				left_tree := grid[row_index][c_index]
				if left_tree >= tree_height { is_visible = false }
			}
		}
		else {
			panic("invalid direction")
		}
	}
	return is_visible
}

fn is_visible(grid [][]int, r_index int, c_index int, tree_height int) !bool {
	if is_in_edge(grid, r_index, c_index) { return true }
	top := is_visible_from(grid, r_index, c_index, tree_height, "top")!
	bot := is_visible_from(grid, r_index, c_index, tree_height, "bot")!
	right := is_visible_from(grid, r_index, c_index, tree_height, "right")!
	left := is_visible_from(grid, r_index, c_index, tree_height, "left")!
	return top || right || bot || left
}

fn print_results(file_name string, count int) {
	println("$file_name File:")
	println("Visible Trees Count: $count")
}