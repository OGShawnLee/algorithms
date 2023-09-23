#include <string>
#include <vector>
#include <fstream>
#include <iostream>

const std::string FILE_PATH = "./input.txt";

std::vector<std::string> get_file_lines(std::string file_path) {
    std::vector<std::string> lines;
    std::ifstream file(file_path);

    if (file.is_open()) {
        std::string line;
        while (getline(file, line)) {
            lines.push_back(line);
        }
        file.close();
    } else {
        printf("Unable to open file: %s\n", file_path.c_str());
    }

    return lines;
}

int main() {
    std::vector<std::string> lines = get_file_lines(FILE_PATH);
    std::string line = lines[0]; // file has only one line

    int floor = 0;
    int basement_index = -1;

    for (int index = 0; index < line.length(); index++) {
        char direction = line[index];

        if (direction == '(') floor++;
        else if (direction == ')') floor--;

        if (floor == -1 && basement_index == -1) {
            basement_index = index + 1;
        }
    }

    printf("Floor Number: %d\n", floor);
    printf("Basement Direction Position: %d\n", basement_index);

    return 0;
}