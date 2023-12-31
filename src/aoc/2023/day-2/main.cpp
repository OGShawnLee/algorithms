#include <fstream>
#include <functional>
#include <string>
#include <vector>

using namespace std;

struct Cube {
  string name;
  int amount;
};

struct Game {
  int id;
  vector<vector<Cube>> sets;
};

void each_line(string file_path, function<void(string)> fn) {
  ifstream file = ifstream(file_path);
  string line;
  while (getline(file, line)) {
    fn(line);
  }
}

// we do parsing right away; we assume the input is always valid
Game parse(string line) {
  Game game;
  string slice;
  bool is_pending = true;
  bool is_missing_cube_quantity = true;

  for (int index = 0; index < line.length(); index++) {
    char token = line[index];

    if (token == ' ' && slice.empty() == false) {
      if (is_pending) {
        if (slice == "Game") slice = "";
        continue;
      }

      if (is_missing_cube_quantity) {
        Cube cube;
        cube.amount = stoi(slice);
        game.sets.back().push_back(cube);
        is_missing_cube_quantity = false;
        slice = "";
      }

      continue;
    }

    // start-token
    if (token == ':') {
      // adding first set
      vector<Cube> initial_set;
      game.sets.push_back(initial_set);

      // setting game id
      game.id = stoi(slice);
      is_pending = false;
      slice = "";
      continue;
    }

    // end-set-token
    if (token == ',') {
      // adding cube name
      Cube &current_cube = game.sets.back().back();
      current_cube.name = slice;
      is_missing_cube_quantity = true;
      slice = "";
      continue;
    }

    // end-set-token 
    if (token == ';') {
      // adding current set last cube name
      Cube &current_cube = game.sets.back().back();
      current_cube.name = slice;

      // adding new set
      vector<Cube> set;
      game.sets.push_back(set);
      is_missing_cube_quantity = true;
      slice = "";
      continue;
    }

    slice += token;
  }

  // each statement ends with a cube name
  Cube &final_cube = game.sets.back().back();
  final_cube.name = slice;

  return game;
}

int main() {
  int id_total = 0;
  int game_power_total = 0;

  each_line("input.txt", [&](string line) {
    Game game = parse(line);
    bool is_possible = true;
    int max_red = 0;
    int max_green = 0;
    int max_blue = 0;

    for (vector<Cube> set : game.sets) {
      for (Cube cube : set) {
        if (cube.name == "red") {
          if (cube.amount > 12) is_possible = false;
          max_red = max(max_red, cube.amount);
        }

        if (cube.name == "green") {
          if (cube.amount > 13) is_possible = false;
          max_green = max(max_green, cube.amount);
        }

        if (cube.name == "blue") {
          if (cube.amount > 14) is_possible = false;
          max_blue = max(max_blue, cube.amount);
        }
      }
    }

    if (is_possible) id_total += game.id;
    game_power_total += max_red * max_green * max_blue;
  });

  printf("ID Total: %d\n", id_total);
  printf("Game Power Total: %d\n", game_power_total);

  return 0;
}