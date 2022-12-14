import std/strformat

proc getDirectionCharValue(letter: char): int =
  if letter == '(':
    return 1
  elif letter == ')':
    return -1
  return 0

proc getBasementDirectionPosition(lines: seq[string]): int =
  var floorNumber = 0
  for line in lines:
    for index, letter in line:
      floorNumber += getDirectionCharValue(letter)
      if floorNumber == -1:
        return index + 1
  raise newException(ValueError, "Unable to Find Basement Direction Position")

proc getFllorNumberFromDirections(lines: seq[string]): int =
  var floorNumber = 0
  for line in lines:
    for letter in line:
      floorNumber += getDirectionCharValue(letter)
  return floorNumber

proc getFileLines(filePath: string): seq[string] =
  return io.readLines(filePath, 1)
  
const input_file_name = "./input.txt"

let directions = getFileLines(input_file_name)
let floorNumber = getFllorNumberFromDirections(directions)
let position = getBasementDirectionPosition(directions)
echo(fmt"Floor Number: {floorNumber} | Basement Direction Position: {position}")
