#include <iostream>
#include "utils.cpp"

using namespace std;

void handle_variable_types() {
    string name = get_string("Enter your name: ");
    int age = get_int("Enter your age: ");
    float height = get_float("Enter your height in meters: ");
    string sex = get_string("What is your sex? (F / M): ");
    string crime = get_string("What is your crime?: ");

    name = capitalize(name);
    sex = capitalize(sex);
    crime = capitalize(crime);

    report_value("Name", name);
    report_value("Age", age);
    report_value("Height", height);
    report_value("Sex", sex);
    report_value("Crime", crime);
}

void handle_math() {
    int a = get_float("Enter a number: ");
    int b = get_float("Enter another number: ");

    int sum = a + b;
    int difference = a - b;
    int product = a * b;
    int quotient = a / b;
    int remainder = a % b;

    report_value("Sum", sum);
    report_value("Difference", difference);
    report_value("Product", product);
    report_value("Quotient", quotient);
    report_value("Remainder", remainder);
}

int main() {
    handle_variable_types();
    handle_math();
    return 0;
}

