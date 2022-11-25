import os { read_lines }
import regex { regex_opt }

struct Tile {
	mut: 
		value int
		is_crossed bool
}

struct TileContext {
	row_index int
	tile_index int
	mut:
		column_counters []int
		row_counters []int
}

fn (mut tile Tile) cross() {
	tile.is_crossed = true
}

fn (mut tile Tile) handle_tile(mut context TileContext) (bool, string) {
	tile.cross()
	row_index := context.row_index
	tile_index := context.tile_index
	context.column_counters[tile_index]++
	context.row_counters[row_index]++
	column_count := context.column_counters[tile_index]
	row_count := context.row_counters[row_index]
	if column_count == 5 && row_count == 5 {
		return true, "Cross!"
	}
	if column_count == 5 {
		return true, "Column"
	}
	if row_count == 5 {
		return true, "Row"
	}
	return false, "None"
}

const (
	input_file_path = "./input.txt"
	example_path = "./example.txt"
)

fn create_board_counters(length int) [][]int {
	return [][]int { 
		cap: length, 
		len: length, 
		init: []int { cap: 5, len: 5, init: 0  }  
	}
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or { panic("unable to read file lines") }
	return lines
}

fn get_rounds_and_board(lines []string) !([]int, [][][]Tile) {
	rounds := lines[0].split(",").map(it.int())
	mut boards := [][][]Tile{}
	mut is_collecting_board := false
	for index in 1..lines.len {
		line := lines[index]
		if is_collecting_board {
			row := parse_str(line)!
			mut board := boards.last()
			board << row // bug: v creates a new array here instead of mutating the original
			boards[boards.len - 1] = board // have to replace here
			if board.len == 5 {
				is_collecting_board = false
			}
		}
		if line == "" {
			is_collecting_board = true
			boards << [][]Tile{}
		}
	}
	return rounds, boards
}

struct CompletedBoard {
	value int
	w_line string
}

fn get_last_winner_board(file_path string) !([][]Tile, int, string) {
	lines := get_file_lines(file_path)!
	rounds, mut boards := get_rounds_and_board(lines)!
	columns := create_board_counters(boards.len)
	rows := create_board_counters(boards.len)
	mut completed_boards := map[int]CompletedBoard {}
	mut last_board_index := 0
	for number in rounds {
		for index, mut board in boards {
			is_completed_board := index in completed_boards
			if is_completed_board { continue }
			mut column_counters := columns[index]
			mut row_counters := rows[index]
			row_loop: for row_index, mut row in board {
				for tile_index, mut tile in row {
					is_already_crossed := tile.is_crossed
					if is_already_crossed || number != tile.value { continue }
					has_won, line_w := tile.handle_tile(mut TileContext {
						row_index: row_index
						tile_index: tile_index,
						column_counters: column_counters,
						row_counters: row_counters
					})
					if has_won {
						last_board_index = index
						completed_boards[index] = CompletedBoard { tile.value, line_w }	
						break row_loop
					} 
				}
			}
		}
	}
	if last_board_index in completed_boards {
		completed_board := boards[last_board_index]
		completed_board_info := completed_boards[last_board_index]
		return completed_board, completed_board_info.value, completed_board_info.w_line
	}
	panic("Unable to Find Last Winner Board")
}

fn get_first_winner_board(file_path string) !([][]Tile, int, string) {
	lines := get_file_lines(file_path)!
	rounds, mut boards := get_rounds_and_board(lines)!
	columns := create_board_counters(boards.len)
	rows := create_board_counters(boards.len)
	for number in rounds {
		for index, mut board in boards {
			mut column_counters := columns[index]
			mut row_counters := rows[index]
			for row_index, mut row in board {
				for tile_index, mut tile in row { 
					if tile.value == number {
						is_already_crossed := tile.is_crossed
						if is_already_crossed { continue }
						has_won, w_line := tile.handle_tile(mut TileContext {
							row_index: row_index
							tile_index: tile_index,
							column_counters: column_counters,
							row_counters: row_counters
						})
						if has_won {
							return board, tile.value, w_line 
						}
					}
				}
			}
		}
	}
	panic("Unable to Find Winner Board")
}

fn get_winner_board_score(
	file_path string, 
	func fn (file_path string) !([][]Tile, int, string)
) !(int, int, string) {
	w_board, w_number, w_line := func(file_path)!
	mut count := 0
	for row in w_board {
		for tile in row {
			if !tile.is_crossed {
				count += tile.value
			}
		}
	}
	score := count * w_number
	return score, w_number, w_line
}

fn parse_str(str string) ![]Tile {
	mut re := regex_opt(r"\s") or { panic("Unable to parse string") }
	cleared := re.replace(str, " ")
	return cleared.split(" ").filter(it != "").map(Tile{ it.int(), false })
}

fn main() {
	example_result := spawn get_winner_board_score(example_path, get_first_winner_board)
	input_result := spawn get_winner_board_score(input_file_path, get_first_winner_board)
	last_example_result := spawn get_winner_board_score(example_path, get_last_winner_board)
	last_input_result := spawn get_winner_board_score(input_file_path, get_last_winner_board)
	mut score, mut w_number, mut w_line := example_result.wait()!
  println("First Board Winner:")
  println(" -- Results from Example File:")
  println(" ---- Winner Board Score: $score | Winner Number: $w_number | Won in: $w_line")
	score, w_number, w_line = input_result.wait()!
	println(" -- Results from Input File:")
  println(" ---- Winner Board Score: $score | Winner Number: $w_number | Won in: $w_line")
	score, w_number, w_line = last_example_result.wait()!
  println("Last Board Winner:")
  println(" -- Results from Example File:")
  println(" ---- Last Winner Board Score: $score | Winner Number: $w_number | Won in: $w_line")
  score, w_number, w_line = last_input_result.wait()!
  println(" -- Results from Input File:")
  println(" ---- Last Winner Board Score: $score | Winner Number: $w_number | Won in: $w_line")
}