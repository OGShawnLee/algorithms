import { readFile } from "fs/promises";
import { resolve } from "path";

const filePath = resolve("./input.txt");
const increasedCount = await getDepthIncreasedAmount(filePath);
console.log(`times a depth measurement increased from the previous one: ${increasedCount}`);

async function getDepthIncreasedAmount(filePath: string) {
  const lines = await getFileLines(filePath);
  let previousDepth = Number(lines[0]);
  let increasedCount = 0;
  for (const line of lines) {
    const depth = Number(line);
    if (depth > previousDepth) increasedCount += 1;
    previousDepth = depth;
  }
  return increasedCount;
}

async function getFileLines(filePath: string) {
  const file = await readFile(filePath, "utf-8");
  return file.split(/\r?\n/);
}
