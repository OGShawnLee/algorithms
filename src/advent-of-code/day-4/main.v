import os { read_lines }
import regex { regex_opt }

struct Tile {
	mut: 
		value int
		is_crossed bool
}

fn (mut tile Tile) cross() {
	tile.is_crossed = true
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

fn get_winner_board(file_path string) !([][]Tile, int, string) {
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
						tile.cross()
						column_counters[tile_index]++
						row_counters[row_index]++
						if column_counters[tile_index] == 5 {
							return board, tile.value, "Column"
						}
						if row_counters[row_index] == 5 {
							return board, tile.value, "Row"
						}
					}
				}
			}
		}
	}
	panic("Unable to Find Winner Board")
}

fn get_winner_board_score(file_path string) !(int, int, string) {
	w_board, w_number, w_line := get_winner_board(file_path)!
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
	example_result := spawn get_winner_board_score(example_path)
	input_result := spawn get_winner_board_score(input_file_path)
	mut score, mut w_number, mut w_line := example_result.wait()!
	println("Results from Example File:")
  println("Winner Board Score: $score | Winner Number: $w_number | Won in: $w_line")
	score, w_number, w_line = input_result.wait()!
	println("Results from Input File:")
  println("Winner Board Score: $score | Winner Number: $w_number | Won in: $w_line")
}