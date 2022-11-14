export default function getDuplicateCount(str: string): number {
  const unique = new Set(str.toLowerCase().replace(/\s+/g, ""));
  let count = 0;
  for (const char of unique) count += str.match(new RegExp(char, "gi")).length > 1 ? 1 : 0;
  return count;
}
