#include <fstream>
#include <functional>
#include <map>
#include <vector>

using namespace std;

short ROCK_SCORE = 1;
short PAPER_SCORE = 2;
short SCISSORS_SCORE = 3;
short LOSE_SCORE = 0;
short DRAW_SCORE = 3;
short WIN_SCORE = 6;

// For Part-1
map<char, string> MOVE_NAMES = {
  {'A', "ROCK"},
  {'X', "ROCK"},
  {'B', "PAPER"},
  {'Y', "PAPER"},
  {'C', "SCISSORS"},
  {'Z', "SCISSORS"}
};

// For Part-2
map<char, string> OUTCOME = {
  {'X', "LOSE"},
  {'Y', "DRAW"},
  {'Z', "WIN"}
};

// For Part-1
map<char, short> MOVE_SCORES = {
  {'A', ROCK_SCORE},
  {'X', ROCK_SCORE},
  {'B', PAPER_SCORE},
  {'Y', PAPER_SCORE},
  {'C', SCISSORS_SCORE},
  {'Z', SCISSORS_SCORE}
};

void each_line(string file_path, function<void(string)> on_line) {
  ifstream file(file_path);
  string line;
  while (getline(file, line)) {
    on_line(line);
  }
}

class Round {
  public:
  string move_elf;
  string move_infered; 
  short infered_score;
  short round_score;

  Round(char move_elf, char move_infered) {
    this->move_elf = MOVE_NAMES[move_elf];
    this->move_infered = MOVE_NAMES[move_infered];
    this->infered_score = this->get_infered_score(move_elf, move_infered);
    this->round_score = this->get_round_score(move_elf, move_infered);
  }

  // For Part-1
  private:
  short get_infered_score(char move_elf, char move_infered) {
    short move_score = MOVE_SCORES[move_infered];
    string move_elf_name = MOVE_NAMES[move_elf];
    string move_infered_name = MOVE_NAMES[move_infered];

    if (move_elf_name == move_infered_name) {
      return DRAW_SCORE + move_score;
    }

    if (move_elf_name == "ROCK" && move_infered_name == "SCISSORS") {
      return LOSE_SCORE + move_score;
    }

    if (move_elf_name == "PAPER" && move_infered_name == "ROCK") {
      return LOSE_SCORE + move_score;
    }

    if (move_elf_name == "SCISSORS" && move_infered_name == "PAPER") {
      return LOSE_SCORE + move_score;
    }

    return WIN_SCORE + move_score;
  }

  // For Part-2
  short get_round_score(char move_elf, char outcome) {
    string move_elf_name = MOVE_NAMES[move_elf];
    string outcome_name = OUTCOME[outcome];

    if (outcome_name == "DRAW") {
      return DRAW_SCORE + MOVE_SCORES[move_elf];
    }

    if (outcome_name == "WIN") {
      if (move_elf_name == "ROCK") {
        return WIN_SCORE + PAPER_SCORE;
      }

      if (move_elf_name == "PAPER") {
        return WIN_SCORE + SCISSORS_SCORE;
      }
    
      return WIN_SCORE + ROCK_SCORE;
    }

    // LOSE
    if (move_elf_name == "PAPER") {
      return LOSE_SCORE + ROCK_SCORE;
    } else if (move_elf_name == "ROCK") {
      return LOSE_SCORE + SCISSORS_SCORE;
    }

    return LOSE_SCORE + PAPER_SCORE;
  }
};

vector<Round> parse(string file_path) {
  vector<Round> rounds;
  each_line(file_path, [&](string line) {
    rounds.push_back(Round(line[0], line[2]));
  });
  return rounds;
}

int main() {
  vector<Round> rounds = parse("input.txt");
  short infered_score= 0;
  short round_score = 0;

  for (Round round : rounds) {
    infered_score += round.infered_score;
    round_score += round.round_score;
  }

  printf("Infered Score (Part-1): %du\n", infered_score);
  printf("Score (Part-2): %du\n", round_score);

  return 0;
}