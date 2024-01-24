#include <fstream>
#include <functional>
#include <map>
#include <vector>

using namespace std;

map<char, short> ITEMS_PRIORITY = {
  {'a', 1},
  {'b', 2},
  {'c', 3},
  {'d', 4},
  {'e', 5},
  {'f', 6},
  {'g', 7},
  {'h', 8},
  {'i', 9},
  {'j', 10},
  {'k', 11},
  {'l', 12},
  {'m', 13},
  {'n', 14},
  {'o', 15},
  {'p', 16},
  {'q', 17},
  {'r', 18},
  {'s', 19},
  {'t', 20},
  {'u', 21},
  {'v', 22},
  {'w', 23},
  {'x', 24},
  {'y', 25},
  {'z', 26},
  {'A', 27},
  {'B', 28},
  {'C', 29},
  {'D', 30},
  {'E', 31},
  {'F', 32},
  {'G', 33},
  {'H', 34},
  {'I', 35},
  {'J', 36},
  {'K', 37},
  {'L', 38},
  {'M', 39},
  {'N', 40},
  {'O', 41},
  {'P', 42},
  {'Q', 43},
  {'R', 44},
  {'S', 45},
  {'T', 46},
  {'U', 47},
  {'V', 48},
  {'W', 49},
  {'X', 50},
  {'Y', 51},
  {'Z', 52},
};

struct Rucksack {
  char common_item;
  short common_item_priority;
  string content;
};

void each_line(string file_path, function<void(string)> on_line) {
  ifstream file(file_path);
  string line;
  while (getline(file, line)) {
    on_line(line);
  }
}

char find_common_char(vector<string> lines) {
  if (lines.size() == 2) {
    for (char bar : lines[0]) {
      for (char foo : lines[1]) {
        if (bar != foo) continue;
        return bar;
      }
    }
  }

  for (char bar : lines[0]) {
    for (char foo : lines[1]) {
      for (char baz : lines[2]) {
        if (bar != foo || bar != baz) continue;
        return bar;
      }
    }
  }

  return '\0';
}

vector<Rucksack> parse(string file_path) {
  vector<Rucksack> rucksacks;
  
  each_line(file_path, [&](string line) {
    size_t index_half = line.size() / 2;
    string first_half = line.substr(0, index_half);
    string second_half = line.substr(index_half, line.size());    
    Rucksack rucksack;
    rucksack.content = line;
    rucksack.common_item = find_common_char({ first_half, second_half });
    rucksack.common_item_priority = ITEMS_PRIORITY[rucksack.common_item];
    rucksacks.push_back(rucksack);
  });

  return rucksacks;
}

int main() {
  vector<Rucksack> rucksacks = parse("input.txt");
  // Part-1
  int common_item_priority_sum = 0;
  // Part-2
  vector<string> group_contents;
  int group_priotity_sum = 0;
  
  for (size_t index = 0; index < rucksacks.size(); index++) {
    Rucksack rucksack = rucksacks[index];
    common_item_priority_sum += rucksack.common_item_priority;
    group_contents.push_back(rucksack.content);

    if (group_contents.size() == 3) {
      char common_char = find_common_char(group_contents);
      group_priotity_sum += ITEMS_PRIORITY[common_char];
      group_contents.clear();
    }
  }

  printf("Common Priority Sum (Part-1): %du\n", common_item_priority_sum);
  printf("Group Priority Sum (Part-2): %du\n", group_priotity_sum);

  return 0;
}
