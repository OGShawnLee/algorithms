import os { read_lines }

const (
	example_path = "./example.txt"
	input_path = "./input.txt"
	move_scores = { "ROCK": 1, "PAPER": 2, "SCISSORS": 3 }
	move_response_win = { "ROCK": "PAPER", "PAPER": "SCISSORS", "SCISSORS": "ROCK" }
	move_response_lose = { "ROCK": "SCISSORS", "SCISSORS": "PAPER", "PAPER": "ROCK" }
)

fn main() {
	i_input_score_future := go get_infered_tournament_score(input_path)
	i_example_score_future := go get_infered_tournament_score(example_path)
	mut score := i_example_score_future.wait()!
	println("Example Infered Tournament Score: $score")
	score = i_input_score_future.wait()!
	println("Input Infered Tournament Score: $score")
	input_score_future := go get_tournament_score(input_path)
	example_score_future := go get_tournament_score(example_path)
	score = example_score_future.wait()!
	println("Example Tournament Score: $score")
	score = input_score_future.wait()!
	println("Input Tournament Score: $score")
}

fn get_file_lines(file_path string) ![]string {
	lines := read_lines(file_path) or {
		panic("Unable to read lines from $file_path")
	}
	return lines
}

fn get_move_score(move string) int {
	return move_scores[move]
}

fn get_round_score(line string) !int {
	move, outcome := parse_line(line)!
	mut score := 3
	mut response := move
	if outcome == "LOSE" {
		score = 0
		response = move_response_lose[move]
	} else if outcome == "WIN" {
		score = 6
		response = move_response_win[move]
	}
	return score + get_move_score(response)
}

fn get_infered_round_score(line string) !int {
	moves := parse_infered_line(line)!
	mut score := 0
	match moves {
		["ROCK", "PAPER"], ["PAPER", "SCISSORS"], ["SCISSORS", "ROCK"] {
			score += get_move_score(moves[1]) + 6
		}
		["ROCK", "SCISSORS"], ["SCISSORS", "PAPER"], ["PAPER", "ROCK"] {
			score += get_move_score(moves[1]) + 0
		}
		else {
			score += get_move_score(moves[1]) + 3
		}
	}
	return score
}

fn get_tournament_score(file_path string) !int {
	mut score := 0
	lines := get_file_lines(file_path)!
	for line in lines {
		round_score := get_round_score(line)!
		score += round_score
	}
	return score
}

fn get_infered_tournament_score(file_path string) !int {
	mut score := 0
	lines := get_file_lines(file_path)!
	for line in lines {
		round_score := get_infered_round_score(line)!
		score += round_score
	}
	return score
}

fn parse_line(line string) !(string, string) {
	parsed_line := line.split(" ").map(fn (element string) string {
		return match element {
			"A" { "ROCK" }
			"B" { "PAPER" }
			"C" { "SCISSORS" }
			"Y" { "DRAW" }
			"X" { "LOSE" }
			"Z" { "WIN" }
			else {
				panic("$element is an invalid move or outcome!")
			}
		}		
	})
	return parsed_line[0], parsed_line[1]
}

fn parse_infered_line(line string) ![]string {
	return line.split(" ").map(fn (element string) string {
		if element == "A" || element == "X" { return "ROCK" }
		if element == "B" || element == "Y" { return "PAPER" }
		if element == "C" || element == "Z" { return "SCISSORS"}
		panic("$element is an invalid move!")
	})
}
