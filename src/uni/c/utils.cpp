#include <iostream>

using namespace std;

string capitalize(string str) {
    str[0] = toupper(str[0]);
    return str;
}

string get_string(string message) {
    string input;
    cout << message;
    cin >> input;
    return input;
}

float get_float(string prompt) {
    float input;
    cout << prompt;
    cin >> input;
    return input;
}

int get_int(string prompt) {
    int input;
    cout << prompt;
    cin >> input;
    return input;
}

template <typename T>
void report_value(string message, T value) {
    cout << message << ": " << value << endl;
}
