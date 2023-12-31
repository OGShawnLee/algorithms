#include <fstream>
#include <functional>
#include <iostream>
#include <string>

using namespace std;

void each_line(string file_path, function<void(string)> fn) {
  ifstream file = ifstream(file_path);
  string line;
  while (getline(file, line)) {
    fn(line);
  }
}

int main() {
  int calibration_value_total = 0;

  each_line("input.txt", [&](string line) {
    string calibration_value = "";
    size_t len = line.length();

    for (size_t index = 0; index < len; index++) {
      if (isdigit(line[index])) {
        calibration_value += line[index];
        break;
      }
    }

    for (size_t index = len; index >= 0; index--) {
      if (isdigit(line[index])) {
        calibration_value += line[index];
        break;
      }
    }

    calibration_value_total += stoi(calibration_value);
  });

  printf("Calibration Value: %i u\n", calibration_value_total);
  return 0;
}