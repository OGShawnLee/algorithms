import os { read_lines }

const (
	example_path = "./example.txt"
	input_path = "./input.txt"
	move_scores = { "ROCK": 1, "PAPER": 2, "SCISSORS": 3 }
)

fn main() {
	input_score_future := spawn get_tournament_score(input_path)
	example_score_future := spawn get_tournament_score(example_path)
	mut score := example_score_future.wait()!
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
	moves := parse_line(line)!
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

fn parse_line(line string) ![]string {
	return line.split(" ").map(fn (element string) string {
		if element == "A" || element == "X" { return "ROCK" }
		if element == "B" || element == "Y" { return "PAPER" }
		if element == "C" || element == "Z" { return "SCISSORS"}
		panic("$element is an invalid move!")
	})
}
