from pathlib import Path

DIGIT_NAMES = {
    "zero": "0",
    "one": "1",
    "two": "2",
    "three": "3",
    "four": "4",
    "five": "5",
    "six": "6",
    "seven": "7",
    "eight": "8",
    "nine": "9"
}

def each_file_line(filepath):
    file = Path(__file__).with_name(filepath)
    with file.open("r") as lines:
        for line in lines:
            yield line

def is_digit_name(string):
    for digit_name in DIGIT_NAMES:
        if digit_name in string:
            return [True, DIGIT_NAMES[digit_name]]
    return [False, ""]

calibration_value_sum = 0

for line in each_file_line("input.txt"):
    acc = ""
    calibration_value = ""

    for char in line:
        if char.isdigit():
            calibration_value += char   
            acc = "" 
            break
    
        acc += char
        [is_digit, digit_value] = is_digit_name(acc)
        if is_digit:
            calibration_value += digit_value
            acc = ""
            break
        
    for char in reversed(line):
        if char.isdigit():
            calibration_value += char
            break

        acc = char + acc
        [is_digit, digit_value] = is_digit_name(acc)
        if is_digit:
            calibration_value += digit_value
            break

    calibration_value_sum += int(calibration_value)

print(calibration_value_sum)