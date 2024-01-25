#include <fstream>
#include <functional>
#include <vector>

using namespace std;

struct Range {
  int min;
  int max;
};

struct Pair {
  Range elf_1;
  Range elf_2;
};

const char RANGE_DELIMITER = '-';
const char PAIR_DELIMITER = ',';

void each_line(string file_path, function<void(string)> on_line) {
  ifstream file(file_path);
  string line;
  while (getline(file, line)) {
    on_line(line);
  }
}

void each_pair(string file_path, function<void(Pair &)> on_pair) {
  string current_digit;
  
  each_line(file_path, [&](string line) {
    Pair pair;
    bool is_first_range = true;

    for (char token : line) {
      if (isdigit(token)) {
        current_digit += token;
        continue;
      }

      if (token == RANGE_DELIMITER) {
        if (is_first_range) {
          pair.elf_1.min = stoi(current_digit);
          current_digit = "";
        } else {
          pair.elf_2.min = stoi(current_digit);
          current_digit = "";
        }

        continue;
      }

      if (token == PAIR_DELIMITER) {
        pair.elf_1.max = stoi(current_digit);
        current_digit = "";
        is_first_range = false;
        continue;
      }
    }

    pair.elf_2.max = stoi(current_digit);
    current_digit = "";
    on_pair(pair);
  });
}

bool is_contained(const Pair &pair) {
  bool first_in_second = pair.elf_1.min >= pair.elf_2.min && pair.elf_1.max <= pair.elf_2.max;
  bool second_in_first = pair.elf_2.min >= pair.elf_1.min && pair.elf_2.max <= pair.elf_1.max;
  return first_in_second || second_in_first;
}

int main() {
  short contained_count = 0;
  each_pair("input.txt", [&](Pair &pair) {
    if (is_contained(pair)) {
      contained_count++;
    }
  });
  printf("Contained Count: %d\n", contained_count);
  return 0;
}