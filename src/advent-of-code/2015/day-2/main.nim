from std/strformat import fmt
from std/strutils import parseInt, split
from std/sequtils import map
from std/algorithm import sorted

proc calculateBoxWrappingPaper(length:int, width:int, height:int): int =
  let small = length * width
  return (2 * length * width) + (2 * width * height) + (2 * height * length) + small

proc getFileLines(filePath:string): seq[string] =
  return io.readLines(filePath, 1000)

proc parsePresentDimensions(line:string): seq[int] =
  return line.split("x").map(proc (letter:string): int = parseInt(letter)).sorted

proc getTotalWrappingPaper(lines:seq[string]): int =
  var paper = 0
  for line in lines:
    let dimensions = parsePresentDimensions(line)
    paper += calculateBoxWrappingPaper(dimensions[0], dimensions[1], dimensions[2])
  return paper

const inputFilePath = "./input.txt"

let dimensions = getFileLines(inputFilePath)
let paper = getTotalWrappingPaper(dimensions)
echo(fmt"Total Wrapping Paper: {paper} square feet")
