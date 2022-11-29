import arrays { fold, map_indexed }
import os { read_lines }

const example_path = "./example.txt"
const input_path = "./input.txt"

fn main() {
	mut board, mut win_round, mut win_text := get_first_board_winner(example_path)!
	mut score := board.get_score(win_round)
	print_results("Example", score, win_round, win_text)
	board, win_round, win_text = get_first_board_winner(input_path)!
	score = board.get_score(win_round)
	print_results("Input", score, win_round, win_text)
	board, win_round, win_text = get_last_board_winner(example_path)!
	score = board.get_score(win_round)
	print_results("Example", score, win_round, win_text)
	board, win_round, win_text = get_last_board_winner(input_path)!
	score = board.get_score(win_round)
	print_results("Input", score, win_round, win_text)
}

struct Board {
	mut: 
		rows []Row
		column_counters []int
}

fn (mut board Board) cross(round int, mut row Row, mut tile Tile) (bool, string) {
	is_already_crossed := tile.is_crossed
	if is_already_crossed || tile.value != round { return false, "None" }
	row.count++
	tile.is_crossed = true 
	board.column_counters[tile.index]++
	won_with_column := board.is_column_complete(tile.index)
	won_with_row := row.is_complete()
	if won_with_column && won_with_row { return true, "T-Shape!" }
	if won_with_column { return true, "Column" }
	if won_with_row { return true, "Row" }
	return false, "None"
}

fn (board Board) get_score(win_round int) int {
	non_crossed_count := fold(board.rows, 0, fn (count int, row Row) int {
		return fold(row.tiles, count, fn (count int, tile Tile) int {
			return count + if tile.is_crossed { 0 } else { tile.value } 
		})
	})
	return non_crossed_count * win_round
}

fn (board Board) is_column_complete(column_index int) bool {
	return board.column_counters[column_index] == 5
}

struct Row {
	tiles []Tile
	mut: count int
}

fn (row Row) is_complete() bool {
	return row.count == 5
}

struct Tile {
	value int
	index int
	mut: is_crossed bool
}

fn get_boards_and_rounds(file_path string) !([]Board, []int) {
	lines := get_file_lines(file_path)!
	rounds := lines[0].split(",").map(it.int())
	mut boards := []Board {}
	for index in 1..lines.len {
		line := lines[index]
		if line == "" {
			boards << Board { []Row {}, []int{ cap: 5, len: 5, init: 0 } }
		} else {
			mut board := boards.last()
			board.rows << Row{ parse_line(line), 0 }
			boards[boards.len - 1] = board
		}
	}
	return boards, rounds 
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or {
		panic("Unable to read lines from $file_path")
	}
	return lines
}

fn get_first_board_winner(file_path string) !(Board, int, string) {
	mut boards, rounds := get_boards_and_rounds(file_path) or {
		panic("Unable to Get First Board Winner -> Unable to Read $file_path")
	}
	for round in rounds {
		for mut board in boards {
			for mut row in board.rows {
				for mut tile in row.tiles {
					has_won, win_text := board.cross(round, mut row, mut tile)
					if has_won { return board, tile.value, win_text }
				}
			}
		}
	}
	panic("Unable to Get First Board Winner -> Missing Rounds for Completing a Board")
}

fn get_last_board_winner(file_path string) !(Board, int, string) {
	mut boards, rounds := get_boards_and_rounds(file_path) or {
		panic("Unable to Get First Board Winner -> Unable to Read $file_path")
	}
	mut completed_index := 0
	mut completed_value := 0
	mut completed_win_text := "None"
	mut completed_boards := map[int]bool {}
	for round in rounds {
		for board_index, mut board in boards {
			if board_index in completed_boards { continue }
			row_loop: for mut row in board.rows {
				for mut tile in row.tiles {
					has_won, win_text := board.cross(round, mut row, mut tile)
					if has_won { 
						completed_index = board_index
						completed_value = tile.value
						completed_win_text = win_text
						completed_boards[board_index] = true 
						break row_loop
					}
				}
			}
		}
	}
	if completed_win_text == "None" { panic("Unable to Find Last Board Winner") }
	return boards[completed_index], completed_value, completed_win_text
}

fn parse_line(line string) []Tile {
	cleared := line.split(" ").filter(it != "")
	return map_indexed(cleared, fn (index int, str string) Tile {
		return Tile { value: str.int(), index: index, is_crossed: false }
	})
}

fn print_results(file_name string, score int, win_round int, win_text string) {
	println(" -- Results from $file_name File")
	println(" ---- Score: $score | Round: $win_round | Text: $win_text")
}
