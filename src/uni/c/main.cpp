#include <iostream>

using namespace std;


int get_input_int(string prompt) {
    int input;
    cout << prompt;
    cin >> input;
    return input;
}

float get_input_float(string prompt) {
    float input;
    cout << prompt;
    cin >> input;
    return input;
}

string get_input_string(string message) {
    string input;
    cout << message;
    cin >> input;
    return input;
}

void handle_variable_types() {
    string name = get_input_string("Enter your name: ");
    int age = get_input_int("Enter your age: ");
    float height = get_input_float("Enter your height in meters: ");
    string sex = get_input_string("What is your sex? (F / M): ");
    string crime = get_input_string("What is your crime? ");

    name[0] = toupper(name[0]);
    sex[0] = toupper(sex[0]);
    crime[0] = toupper(crime[0]);


    cout << "Name: " << name << endl;
    cout << "Age: " << age << endl;
    cout << "Height: " << height << endl;
    cout << "Sex: " << sex << endl;
    cout << "Crime: " << crime << endl;
}

int main() {
    handle_variable_types();
    return 0;
}

