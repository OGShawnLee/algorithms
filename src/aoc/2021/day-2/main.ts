import { resolve } from "path";
import { getFileLines } from "@utils";

const INPUT_FILE = resolve("./input.txt");

const position = await getSubmarinePosition(INPUT_FILE);
console.log(`Submarine Position: ${position}`);

async function getSubmarinePosition(filePath: string): Promise<number> {
  const lines = await getFileLines(filePath);
  let forward = 0;
  let depth = 0;
  for (const line of lines) {
    const [direction, value] = parseLine(line);
    if (direction === "forward") forward += value;
    if (direction === "up") depth -= value;
    if (direction === "down") depth += value;
  }
  return forward * depth;
}

function parseLine(line: string): [string, number] {
  const parsedLine = line.split(" ");
  const direction = parsedLine[0];
  const value = +parsedLine[1];
  return [direction, value];
}
