#include <fstream>
#include <functional>
#include <vector>
#include <iostream>

using namespace std;

void each_line(string file_path, function<void(string)> on_line) {
  ifstream file(file_path);
  string line;
  while (getline(file, line)) {
    on_line(line);
  }
}

vector<int> parse(string file_path) {
  vector<int> elf_calories;
  int current_elf_calories = 0;

  each_line(file_path, [&](string line) {
    if (line[0] == '\0') {
      elf_calories.push_back(current_elf_calories);
      current_elf_calories = 0;
    } else {
      current_elf_calories += stoi(line);
    }
  });

  return elf_calories;
}

int main() {
  vector<int> elf_calories = parse("input.txt");

  int maximum = 0;
  int second_maximum = 0;
  int third_maximum = 0;

  for (int calories : elf_calories) {
    if (calories > maximum) {
      third_maximum = second_maximum;
      second_maximum = maximum;
      maximum = calories;
    } else if (calories > second_maximum) {
      third_maximum = second_maximum;
      second_maximum = calories;
    } else if (calories > third_maximum) {
      third_maximum = calories;
    }
  }

  int total = maximum + second_maximum + third_maximum;

  printf("Maximum Calories: %du\n", maximum);
  printf("Total Maximum Calories: %du\n", total);

  return 0;
}