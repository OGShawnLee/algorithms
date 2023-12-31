#include <fstream>
#include <functional>
#include <iostream>
#include <map>
#include <string>

using namespace std;

const string DIGIT_NAMES[] = { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };
const map<string, char> DIGIT_NAMES_VALUES = {
  { "zero", '0' },
  { "one", '1' },
  { "two", '2' },
  { "three", '3' },
  { "four", '4' },
  { "five", '5' },
  { "six", '6' },
  { "seven", '7' },
  { "eight", '8' },
  { "nine", '9' },
};

void each_line(string file_path, function<void(string)> fn) {
  ifstream file = ifstream(file_path);
  string line;
  while (getline(file, line)) {
    fn(line);
  }
}

struct Digit {
  bool is_digit;
  char value;
};

Digit get_digit_from_slice(string str) {
  Digit digit = { false, '0' };
  
  for (string digit_name : DIGIT_NAMES) {
    if (str.find(digit_name) != string::npos) {
      digit.is_digit = true;
      digit.value = DIGIT_NAMES_VALUES.at(digit_name);
      break;
    }
  }

  return digit;
}

int main() {
  int calibration_value_total = 0;

  each_line("input.txt", [&](string line) {
    string calibration_value = "";
    size_t len = line.length();
    string slice;

    for (size_t index = 0; index < len; index++) {
      slice += line[index];
      Digit digit = get_digit_from_slice(slice);

      if (digit.is_digit) {
        calibration_value += digit.value;
        slice = "";
        break;
      }

      if (isdigit(line[index])) {
        calibration_value += line[index];
        break;
      }
    }

    for (size_t index = len; index >= 0; index--) {
      slice.insert(slice.begin(), line[index]); // insert at the beginning because we're going backwards
      Digit digit = get_digit_from_slice(slice);

      if (digit.is_digit) {
        calibration_value += digit.value;
        slice = "";
        break;
      }
     
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