import { readFile } from "fs/promises";
import { resolve } from "path";

const filePath = resolve("./input.txt");
const increasedCount = await getDepthIncreasedAmount(filePath);
console.log(`times a depth measurement increased from the previous one: ${increasedCount}`);
const windowIncreasedAmount = await getDepthSlidingWindowIncreasedAmount(filePath, 3);
console.log(`3-sliding-window depth measurement increased count: ${windowIncreasedAmount}`);

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

async function getDepthSlidingWindowIncreasedAmount(filePath: string, windowLength: number) {
  const lines = await getFileLines(filePath);
  let increasedCount = 0;
  let currentSum = 0;
  let previousSum = 0;
  for (let index = 0; index < lines.length; index++) {
    currentSum += Number(lines[index]);
    if (index >= windowLength) {
      currentSum -= Number(lines[index - windowLength]);
      if (currentSum > previousSum) increasedCount++;
      previousSum = currentSum;
    }
  }
  return increasedCount;
}

async function getFileLines(filePath: string) {
  const file = await readFile(filePath, "utf-8");
  return file.split(/\r?\n/);
}
