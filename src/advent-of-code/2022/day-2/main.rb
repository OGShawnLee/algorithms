FILE_PATH_EXAMPLE = "./example.txt"
FILE_PATH_INPUT = "./input.txt"
MOVE_SCORES = { "ROCK": 1, "PAPER": 2, "SCISSORS": 3 }

def get_file_lines file_path
  IO.readlines(file_path, chomp: true)
end

def get_tournament_score file_path
  score = 0
  lines = get_file_lines(file_path)
  for line in lines
    score += get_round_score(line)
  end
  score
end

def get_move_score move
  MOVE_SCORES[move.to_sym]
end

def get_round_score line
  score = 0
  moves = parse_line(line)
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

score = get_tournament_score(FILE_PATH_EXAMPLE)
puts "Example Tournament Score: #{score}"
score = get_tournament_score(FILE_PATH_INPUT)
puts "Input Tournament Score: #{score}"
