import { readFile } from "fs/promises";

export async function getFileLines(filePath: string) {
  const file = await readFile(filePath, "utf-8");
  return file.split(/\r?\n/);
}
