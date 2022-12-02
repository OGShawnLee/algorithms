FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"
MOVE_RESPONSE_WIN = { "ROCK": "PAPER", "PAPER": "SCISSORS", "SCISSORS": "ROCK" } 
MOVE_RESPONSE_LOSE = { "ROCK": "SCISSORS", "SCISSORS": "PAPER", "PAPER": "ROCK" } 
MOVE_SCORES = { "ROCK": 1, "PAPER": 2, "SCISSORS": 3 }

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_tournament_score lines
  score = 0
  for line in lines
    score += get_round_score(line)
  end
  score
end

def get_infered_tournament_score lines
  score = 0
  for line in lines
    score += get_infered_round_score(line)
  end
  score
end

def get_move_score move
  MOVE_SCORES[move.to_sym]
end

def get_round_score line
  score = 3
  move, outcome = parse_line(line)
  response = move
  if outcome == "WIN"
    score = 6
    response = MOVE_RESPONSE_WIN[move.to_sym]
  elsif outcome == "LOSE"
    score = 0
    response = MOVE_RESPONSE_LOSE[move.to_sym]
  end
  score + get_move_score(response)
end

def get_infered_round_score line
  score = 0
  moves = parse_infered_line(line)
  case moves
  when ["ROCK", "PAPER"], ["PAPER", "SCISSORS"], ["SCISSORS", "ROCK"]
    score += get_move_score(moves[1]) + 6 
  when ["ROCK", "SCISSORS"], ["SCISSORS", "PAPER"], ["PAPER", "ROCK"]
    score += get_move_score(moves[1])
  else
    score += get_move_score(moves[1]) + 3
  end
  score
end

def parse_line line
  line.split(" ").map do |element|
    case element
    when "A" then "ROCK"
    when "B" then "PAPER" 
    when "C" then "SCISSORS" 
    when "Y" then "DRAW" 
    when "X" then "LOSE" 
    when "Z" then "WIN" 
    else
      raise "#{element} is an invalid move or outcome!"
    end
  end
end 

def parse_infered_line line
  line.split(" ").map do |element|
    case element
    when "A", "X"
      "ROCK"
    when "B", "Y"
      "PAPER"
    when "C", "Z"
      "SCISSORS"
    else
      raise "#{element} is an invalid move!"
    end
  end
end

def print_results lines, fn, message
  score = method(fn).call(lines)
  puts "#{message} Tournament Score: #{score}"
end

input_lines = get_file_lines(FILE_PATH_INPUT) 
example_lines = get_file_lines(FILE_PATH_EXAMPLE) 
print_results(example_lines, :get_infered_tournament_score, "Example Infered")
print_results(input_lines, :get_infered_tournament_score, "Input Infered")
print_results(example_lines, :get_tournament_score, "Example")
print_results(input_lines, :get_tournament_score, "Input")
